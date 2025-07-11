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

export default { authorize, whoami, redirect_to_default_lab, get_chorus_lab_backend };
