#
# different screen utils
#

set -a

function dump_screen_output {
    local name=$1
    if [ -z "$name" ]
    then 
        echo "usage: dump_screen_output <screen name or id> <file>"
        return 0
    fi
    local file=${2:-/tmp/screen_output}

    mkdir -p "$(dirname "$file")"
    if screen -X -S "$name" hardcopy -h $file
    then
        echo "screen $name log is dumped to $file"
    else
        echo -e "ERROR: bad screen name $name\n\nexisting screens:"
        screen -ls
    fi
}

function dump_screens_output {
    local folder=${1:-/tmp/screen_output.d}
    if [ -z "$folder" ]
    then 
        echo "usage: dump_screens_output <output folder>"
        return 0
    fi

    local ident
    for ident in $(screen -ls | grep -P '^\s+\d+' | awk '{ print $1 }')
    do 
        number=${ident%.*}
        name=${ident#*.}

        dump_screen_output $number "$folder/$name.$number.txt"
    done
}


set +a
