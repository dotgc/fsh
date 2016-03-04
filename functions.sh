### Extract Archives ###
function extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjvf $1    ;;
            *.tar.gz)    tar xzvf $1    ;;
            *.bz2)       bzip2 -d $1    ;;
            *.rar)       unrar2dir $1    ;;
            *.gz)        gunzip $1    ;;
            *.tar)       tar xf $1    ;;
            *.tbz2)      tar xjf $1    ;;
            *.tgz)       tar xzf $1    ;;
            *.zip)       unzip2dir $1     ;;
            *.Z)         uncompress $1    ;;
            *.7z)        7z x $1    ;;
            *.ace)       unace x $1    ;;
            *)           echo "'$1' cannot be extracted via extract()"   ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

function compress() {
    if [[ -n "$1" ]]; then
        FILE=$1
        case $FILE in
            *.tar ) shift && tar cf $FILE $* ;;
            *.tar.bz2 ) shift && tar cjf $FILE $* ;;
            *.tar.gz ) shift && tar czf $FILE $* ;;
            *.tgz ) shift && tar czf $FILE $* ;;
            *.zip ) shift && zip $FILE $* ;;
            *.rar ) shift && rar $FILE $* ;;
        esac
    else
        echo "usage: compress <foo.tar.gz> ./foo ./bar"
    fi
}

function chs(){
    sudo chmod 777 $1 $2
}

#bu - Back Up a file. Usage "bu filename.txt"
function bu () {
    cp $1 ${1}-`date +%Y%m%d%H%M`.backup;
}

function install() {
    sudo apt-get install -y $1
}

function mkcdr () {
    mkdir -p "$@" && cd "$@"
}

function top10() {
    history | awk '{a[$2]++ } END{for(i in a){print a[i] " " i}}' | sort -rn | head;
}

function dirsize () {
    du -shx * .[a-zA-Z0-9_]* 2> /dev/null | egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
    egrep '^ *[0-9.]*M' /tmp/list
    egrep '^ *[0-9.]*G' /tmp/list
    rm -rf /tmp/list
}

function myip() {
    local ip=$(curl http://ifconfig.me/ip)
    echo $ip
}

#netinfo - shows network information for your system
function netinfo () {
    echo "--------------- Network Information ---------------"
    /sbin/ifconfig | awk /'inet addr/ {print $2}'
    /sbin/ifconfig | awk /'Bcast/ {print $3}'
    /sbin/ifconfig | awk /'inet addr/ {print $4}'
    /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
    echo "${myip()}"
    echo "---------------------------------------------------"
}

# find shorthand
function f() {
    find . -name "$1" 2>&1 | grep -v 'Permission denied'
}

function psa () {
    ps aux | grep $1
}

function showpkg () {
    apt-cache pkgnames | grep -i "$1" | sort
    return;

}
