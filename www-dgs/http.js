const fs = require("fs");

function get_roles_by_user(user) {
    let roles = [user],
        k = 0;
    while (k < roles.length) {
        let other_roles = access.roles[roles[k]] ?? [];
        for (let i = 0; i < other_roles.length; i ++) {
            const other_role = other_roles[i];
            if (!roles.includes(other_role)) {
                roles.push(other_role);
            }
        }
        k ++;
    }
    if (!roles.includes("*")) {
        roles.push("*");
    }
    return roles;
}

function get_roles_by_uri(uri) {
    let path = "",
        roles = [];
    for (const other_path in access.paths) {
        if (other_path.endsWith("/")) {
            other_path = other_path.slice(0, -1);
        }
        if (uri == other_path || uri.startsWith(`${other_path}/`)) {
            if (other_path.length >= path.length) {
                path = other_path;
                roles = [].concat(access.paths[path]);
            }
        }
    }
    return roles;
}

function has_access(user, uri) {
    let user_roles = get_roles_by_user(user),
        uri_roles = get_roles_by_uri(uri);
    return user_roles.some(r => uri_roles.includes(r));
}

function authorize(r) {
    let user = r.variables.authenticated_user,
        uri = r.variables.protected_uri;
    r.return(has_access(user, uri) ? 200 : 403);
}

function whoami(r) {
    let user = r.variables.authenticated_user;
    r.warn(`/whoami: ${user}`);
    r.headersOut["Content-Type"] = "text/plain"
    r.return(200, user);
}

const notebooks_path = "/usr/share/nginx/html/notebooks";

function readdir_notebooks(r) {
    let user = r.variables.authenticated_user,
        files = fs.readdirSync(notebooks_path);
    let result = files.filter((file) => has_access(user, `/notebooks/${file}`));
    r.headersOut["Content-Type"] = "application/json";
    r.return(200, JSON.stringify({ result: result }));
}

const uploads_path = "/uploads";

function get_user_uploads_path(r) {
    let user = r.variables.authenticated_user;
    return `${uploads_path}/${user}`;
}

function get_user_uploads_prefix(r) {
    let user = r.variables.authenticated_user;
    return user.toLowerCase().replace(/@.*/, "").replace(/[^0-9a-z]+/g, "") + "_";
}

function validate_filename(filename) {
    let length = (new TextEncoder()).encode(filename).length;
    return (
        0 < length && length <= 255 &&
        !/[\x00-\x1f"\\/:|<>*?]/.test(filename) &&
        !filename.endsWith(".")
    );
}

function generate_filename(r, name) {
    let prefix = get_user_uploads_prefix(r),
        filename = prefix + name;
    if (!validate_filename(filename)) {
        return;
    }
    return filename;
}

function uploads(r) {
    let method = r.method,
        name = r.uri.match("^/uploads/(.*)")[1];
    if (method == "GET" && name == "") {
        return uploads_get(r);
    }
    else if (method == "PUT" && name != "") {
        return uploads_put(r, name);
    }
    else if (method == "DELETE" && name != "") {
        return uploads_delete(r, name);
    }
    else {
        r.return(400, "Invalid upload action");
    }
}

function uploads_get(r) {
    let path = get_user_uploads_path(r),
        prefix = get_user_uploads_prefix(r),
        result = [];
    if (fs.existsSync(path)) {
        let files = fs.readdirSync(path);
        result = files.map((filename) => {
            if (!(filename.startsWith(prefix) && filename.length > prefix.length)) {
                return;
            }
            let stat = fs.statSync(`${path}/${filename}`, {throwIfNoEntry: false});
            if (!(stat && stat.isFile())) {
                return;
            }
            return {
                name: filename.slice(prefix.length),
                size: stat.size,
                time: stat.birthtimeMs,
            };
        }).filter((entry) => entry);
        result.sort((a, b) => a.time - b.time);
    }
    r.headersOut["Content-Type"] = "application/json";
    r.return(200, JSON.stringify({ result: result }));
}

function uploads_put(r, name) {
    let path = get_user_uploads_path(r),
        filename = generate_filename(r, name),
        source = r.variables.request_body_file;
    if (!filename) {
        r.return(400, "Invalid file name");
        return;
    }
    if (!source) {
        r.return(400, "Missing data");
        return;
    }
    if (!fs.existsSync(path)) {
        try {
            fs.mkdirSync(path);
        }
        catch (e) {
            if (!fs.existsSync(path)) {
                r.return(500, e.message);
                return;
            }
        }
    }
    try {
        fs.renameSync(source, `${path}/${filename}`);
    }
    catch (e) {
        r.return(500, e.message);
        return;
    }
    return uploads_get(r);
}

function uploads_delete(r, name) {
    let filename = generate_filename(r, name);
    if (!filename) {
        r.return(400, "Invalid file name");
        return;
    }
    let path = get_user_uploads_path(r);
    try {
        fs.unlinkSync(`${path}/${filename}`);
    }
    catch (e) {
        r.return(e.message == "No such file or directory" ? 404 : 500, e.message);
        return;
    }
    return uploads_get(r);
}

export default { authorize, whoami, readdir_notebooks, uploads };
