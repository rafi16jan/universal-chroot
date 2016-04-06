#!/bin/sh -e
#This script is from the dnscheid crouton git, all appreciation goes to him.

echo 'Downloading latest debootstrap...' 1>&2
d='https://anonscm.debian.org/gitweb/?p=d-i/debootstrap.git;a=snapshot;h=HEAD;sf=tgz'
if ! wget -O- --no-verbose --timeout=60 -t2 "$d"  \
        | tar -C "$tmp" --strip-components=1 -zx 2>/dev/null; then
    echo 'Download from Debian gitweb failed. Trying latest release...' 1>&2
    d='http://httpredir.debian.org/debian/pool/main/d/debootstrap/'
    f="`wget -O- --no-verbose --timeout=60 -t2 "$d" \
            | sed -ne 's ^.*\(debootstrap_[0-9.]*.tar.gz\).*$ \1 p' \
            | tail -n 1`"
    if [ -z "$f" ]; then
        error 1 'Failed to download debootstrap.
Check your internet connection or proxy settings and try again.'
    fi
    v="${f#*_}"
    v="${v%.tar.gz}"
    echo "Downloading debootstrap version $v..." 1>&2
    if ! wget -O- --no-verbose --timeout=60 -t2 "$d$f" \
            | tar -C "$tmp" --strip-components=1 -zx 2>/dev/null; then
        error 1 'Failed to download debootstrap.'
    fi
fi
