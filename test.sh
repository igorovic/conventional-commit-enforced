#!/usr/bin/env sh

case `uname` in
    (*CYGWIN*|*MINGW*|*MSYS*)
        # fallback for Windows users.
        
        echo "$1"
       echo " I ran this"
    exit 1;;
esac
echo "I am here"