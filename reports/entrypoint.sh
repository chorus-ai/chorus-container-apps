#!/bin/sh
set -eu

warn() {
  printf '%s %s\n' "$(date '+%FT%T')" "$*" >&2
}

main() {
  warn "ENTRYPOINT starting; $(id)"

  set -x
  exec /app/CHoRUSReports.R "$@"
}

main "$@"; exit 1
