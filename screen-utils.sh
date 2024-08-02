#
# different screen utils
#

function dump_screen_output {
    name=$1
    if [ -z "$name" ]
    then 
        echo "usage: dump_screen_output <screen name or id> <file>"
        return 0
    fi
    file=${2:-/tmp/screen_output}

    mkdir -p "$(dirname "$file")"
    if screen -X -S "$name" hardcopy -h $file
    then
        echo "dumped to $file"
    else
        echo -e "ERROR: bad screen name $name\n\nexisting screens:"
        screen -ls
    fi
}

