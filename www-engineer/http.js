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

function redirect_to_default_lab(r) {
    let backend = r.variables.chorus_lab_backend_template,
        user = r.variables.authenticated_user,
        lab = backend.includes("*") ?
            user.toLowerCase().replace(/@.*/, "").replace(/[^0-9a-z]+/g, "") :
            "default",
        uri = `/lab/${lab}/`;
    if (has_access(user, uri)) {
        r.return(303, uri);
    }
    else {
        r.return(403);
    }
}

function redirect_to_default_pg(r) {
    let backend = r.variables.chorus_pg_backend_template,
        user = r.variables.authenticated_user,
        lab = backend.includes("*") ?
            user.toLowerCase().replace(/@.*/, "").replace(/[^0-9a-z]+/g, "") :
            "default",
        uri = `/pgadmin/${lab}/`;
    if (has_access(user, uri)) {
        r.return(303, uri);
    }
    else {
        r.return(403);
    }
}

function get_chorus_lab_backend(r) {
    let template = r.variables.chorus_lab_backend_template,
        uri = r.variables.uri,
        lab = uri.match(/^\/lab\/([^/]+)/)[1] ?? "undefined";
    lab = lab.toLowerCase().replace(/@.*/, "").replace(/[^0-9a-z]+/g, "");
    if (template.endsWith("/")) {
        template = template.slice(0, -1);
    }
    return template.replaceAll("*", lab);
}

function get_chorus_pg_backend(r) {
    let template = r.variables.chorus_pg_backend_template,
        user = r.variables.authenticated_user,
        lab = template.includes("*") ?
            user.toLowerCase().replace(/@.*/, "").replace(/[^0-9a-z]+/g, "") :
            "default"
    if (template.endsWith("/")) {
        template = template.slice(0, -1);
    }
    return template.replaceAll("*", lab);
}

export default { authorize, whoami, redirect_to_default_lab, redirect_to_default_pg, get_chorus_lab_backend, get_chorus_pg_backend };
