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

function deny_user(r) {
    let user = r.variables.remote_user,
        uri = r.variables.protected_uri;
    if (has_access(user, uri)) {
        return "";
    }
    return "DENY";
}

function whoami(r) {
    let user = r.variables.remote_user;
    r.warn(`/whoami: ${user}`);
    r.headersOut["Content-Type"] = "text/plain"
    r.return(200, user);
}

export default { deny_user, whoami };
