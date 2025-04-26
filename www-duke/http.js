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

function get_rcmi_backend(r) {
    let user = r.variables.authenticated_user;
    let lab = user.toLowerCase().replace(/@.*/, "").replace(/[^0-9a-z]+/g, "").substring(0,12);
    let template = r.variables.chorus_lab_backend_template;
    let end_uri =  template.replaceAll("*", lab).concat("/");
    return end_uri;
}


export default { authorize, whoami, get_rcmi_backend };
