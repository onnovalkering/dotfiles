#!/bin/bash

compress() {
    if [ $# -eq 0 ]; then
        echo -e "No arguments specified.";
        return 1;
    fi

    if [ -f $1 ] || [ -d $1 ]; then
        target="${1%%.*}.tar.gz"
        if [ -f $target ]; then
            echo "'$target' already exists.";
        fi

        tar czf $target $1
    else 
        echo "'$1' is not a valid file/directory.";
    fi
}

extract () {
    if [ $# -eq 0 ]; then
        echo -e "No arguments specified.";
        return 1;
    fi

    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.7z)        7z x $1        ;;
            *) echo "'$1' cannot be extracted." ;;
        esac
    else
        echo "'$1' is not a valid file."
    fi
}

transfer() { 
    if [ $# -eq 0 ]; then 
        echo -e "No arguments specified."; 
        return 1; 
    fi

    tmpfile=$(mktemp -t transferXXX); 
    if tty -s; then
        basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g');
        curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile;
    else 
        curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile; 
    fi
    
    cat $tmpfile; 
    rm -f $tmpfile;
    echo ""
}