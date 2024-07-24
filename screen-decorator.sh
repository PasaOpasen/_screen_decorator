

function _fix_env {
    #
    # removes $1 string from env variables
    #   and changes current environment
    #

    local name="$1"

    [ -n "$name" ] || return 0

    for record in $(env | grep -E "^[^=]*$name.*=")
    do
        local n="${record%%=*}"
        local v="${record#*=}"

        local s="${n/$name}"

        unset $n
        export $s=$v
    done 
}


function _screen_env_fixer {

    local found=
    local name=

    for arg in $@
    do 
        if [ -n "$found" ]
        then
            name="$arg"
            break
        fi

        if echo "$arg" | grep -E "\-.*S" &> /dev/null
        then
            found=1
        fi
    done

    if [ -n "$name" ]
    then
        _fix_env "$name"
    fi

}

function _screen_decorator {
    _screen_env_fixer "$@"
    /usr/bin/screen "$@"
}

if [ -e /usr/bin/screen ] 
then
    alias screen=_screen_decorator
fi



