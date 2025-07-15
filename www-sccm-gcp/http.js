function whoami(r) {
    let user = r.variables.email_cache;
    r.warn(`/whoami: ${user}`);
    r.headersOut["Content-Type"] = "text/plain"
    r.return(200, user);
}

export default { whoami };
