#!/usr/bin/env bash

# languages
languages=`echo "python bash lua" | tr ' ' '\n'`

# core-utils
coreutils_org="arch b2sum base32 base64 basename basenc cat chcon chgrp chmod chown chroot cksum comm coreutils cp csplit cut date dd df dir dircolors dirname du echo env pand pr factor false fmt fold groups head hostid hostname id install join kill link ln logname ls md5sum mkdir mkfifo mknod mktemp mv nice nl nohup nproc numfmt od paste pathchk pinky pr printenv printf p pwd readlink realpath rm rmdir runcon seq sha1sum sha224sum sha256sum sha384sum sha512sum shred shuf sleep sort split stat stdbuf stty sum sync tac tail tee test timeout touch tr true truncate tsort tty uname unpand uniq unlink uptime users vdir wc who whoami yes"
coreutils=`echo "$coreutils_org awk br df fd fdisk find grep mount rg tar tree xargs" | tr ' ' '\n'`

# selected
selected=`printf "$languages\n$coreutils" | fzf`
read -p "query: " query

if printf $languages | grep -qs $selected; then
    query=`echo $query | tr ' ' '+'`
    tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | less -r"
fi
