## .bash_functions
## 
## Less than trival functions
function logdiff() {
    local file="$1"

    cvs diff $file |egrep '^(\+|\-)'  | tail +3 > /tmp/wdr1.cvs.tmp
    cvs commit -m "`cat /tmp/wdr1.cvs.tmp`" $file
    cat /tmp/wdr1.cvs.tmp
    rm /tmp/wdr1.cvs.tmp
}
    

function duser () {
  local user="$1"
  dump_user $user > dout.txt
  xmlpretty dout.txt > dout.txt.pretty  

}


function edit_plus_templates () {
    pushd .

     cd $HOME/dev/yahoo/my/templates
    `xterm -font fixed -geometry 80x22+1+3` &
     cd $HOME/dev/yahoo/servers/my/incoming/feed/support/xmlplusfeed
    `xterm -font fixed -geometry 80x24+1+325` &
     cd $HOME/dev/yahoo/servers/my/incoming/feed/support/xmlplusfeed/real_xml
    `xterm -font fixed -geometry 80x24+1+673` &

     cd $HOME/dev/yahoo/my/include/yplus/feed
    `xterm -font fixed -geometry 80x49+502+0` &
     cd $HOME/dev/yahoo/servers/my/incoming/feed/support/xmlplusfeed/templates
    `xterm -font fixed -geometry 80x24+502+673` &

     popd
}

function setup_env ()  {
   `xterm -font fixed -geometry 80x54+0+0` &
   `xterm -font fixed -geometry 80x24+520+64` &
   `xterm -font fixed -geometry 80x24+520+412` &
}

function setup_env_yahoo ()  {
    `xterm -font fixed -geometry 80x24+520+673` &
#    `xterm -font fixed -geometry 80x74+0+0` &
    nohup `nohup emacs -geometry 80x76+0+0 2>&1` &
    sleep 1;
    `xterm -font fixed -geometry 80x49+520+0` &
}

function setup_env_and_leave () {
    setup_env_yahoo
    sleep 1;
    exit;
}

yfresh_my_test ()
{
    pushd . 
    local tests="$1";
    cd /home/yfresh;
    ./yfresh_admin.pl --check-property=My --suppress-email --verbose=3 --print-results  --debug --run-tests=$tests
    popd 
}

tscp ()
{
    for i in $*
    do
        cp -p $i `date "+$i.%Y-%m-%d.%H-%M"`
    done    
}


## Function for pushing files to the feed machines
fpush ()
{
    for i in $*
    do
      for j in wdr1@incoming1.my.yahoo.com: wdr1@incoming2.my.yahoo.com:;
      do
        echo "Copying '$i' to '$j'..."
        scp $i $j
      done
      shift;
    done
    
}

## Function for pushing files to the feed machines
fdo ()
{
  for j in wdr1@incoming1.my.yahoo.com wdr1@incoming2.my.yahoo.com;
  do
    echo "Running 'ssh $j $*"
    ssh $j $*
  done
}

## rot13 function
rot13()
{
        if [ $# = 0 ] ; then
                tr "[a-m][n-z][A-M][N-Z]" "[n-z][a-m][N-Z][A-M]"
        else
                tr "[a-m][n-z][A-M][N-Z]" "[n-z][a-m][N-Z][A-M]" < $1
        fi
}


tstar ()
{
    local dir="$1";
    local name="$2";
    if [ -z $name ]
    then
        name=$dir
    fi
    local tarball=`date "+$name-%m%d%y.tar.gz"`;
    echo tar czvf $tarball $dir;
    tar czvf $tarball $dir;
} 


## csh-like Repeat
repeat ()
{ 
    local count="$1" i;
    shift;
    for i in $(seq 1 "$count");
    do
        eval "$@";
    done
}


# Subfunction needed by `repeat'.
seq ()
{ 
    local lower upper output;
    lower=$1 upper=$2;

    if [ $lower -ge $upper ]; then return; fi
    while [ $lower -le $upper ];
    do
        echo -n "$lower "
        lower=$(($lower + 1))
    done
    echo "$lower"
}


## Don't really need this, but example about how to set TITLEBAR
function proml
{
case $TERM in
    xterm*)
        local TITLEBAR='\[\033]0;\u@\h  \w\007\]'
        ;;
    *)
        local TITLEBAR=''
        ;;
esac

PS1="${TITLEBAR}\
[\t] \h:\w \!% \
\$ "
PS2='> '
PS4='+ '
}


## Function to clean up everything a little
function maid () {
    find . -name "*~" -print -o       \
               -name ".*~" -print -o      \
               -name "dead.*~" -print -o  \
               -name "sql*.buf" -print

    echo "Two seconds until removal..."
    sleep 2;           

    echo "Removing..."
    find . -name "*~" -exec rm {} \; -o  \
               -name ".*~" -exec rm {} \; -o \
               -name "dead.*~" -exec rm {} \; -o \
               -name "sql*.buf" -exec rm {} \;
    echo "Done."
}

## Function to build a tarball containing my personalization files 
## (To make it easy to move 'em around)
function build_bundle () {
    cd 
    rm ~/.*~
    tar cvf .dots.tar .bash* .emacs .aliases .login .logout .sql* \
       emacslib/* .ora_8.1.5.env.tcsh .jdk1.1.env.tcsh .tcshrc .vimrc \
       .ssh/identity.pub
   gzip -f .dots.tar
}


## Function for command-line completion of ssh 
function compgen_ssh () {
    echo

    local i;
    local j;
    COMPREPLY=();

    ## This isn't the best way to do this, but bash isn't passing
    ## the correct value for $2 when there's an @ present
    local w=${COMP_WORDS[ ${#COMP_WORDS[@]}-1 ]}

    local atcheck=${w##*\@};
    if [ ${atcheck:-' '} == $w ]; then
      for i in ${COMPGEN_SSH_USERS[@]}; do
         if [ ${i##$w} != $i ]; then
            for j in ${COMPGEN_SSH_HOSTS[@]}; do
               COMPREPLY=(${COMPREPLY[@]} "$i@$j");
            done;
         fi;
      done;
    else 
      local user=${w%%\@*}
      for i in ${COMPGEN_SSH_HOSTS[@]}; do
         j="$user@$i"
         if [ ${j##$w} != $j ]; then
            COMPREPLY=(${COMPREPLY[@]} "@$i");
         fi
      done;
    fi

}


function compgen_cvs () {
    COMPREPLY=();
}


## Yahoo functions (curtesy of Steve's .souders file)
function mssh {
    local hostlist
    local command

    if [[ "" == "$2" || ("-f" = "$1" && "" = "$3") ]]; then
        echo "Usage: $0 -f hostfile command "
        echo "Usage: $0 hostlist command "
        echo "       Be sure to quote hostlist "
        return
    elif [ "-f" = "$1" ]; then
        hostlist=`cat $2`
        command=$3
    else
        hostlist=$1
        command=$2
    fi

    for host in $hostlist 
    do
        echolog "ssh -x $host -l yahoo '$command'"
        ssh -x $host -l yahoo "$command"
    done
}

function spush {
    local hostlist
    local source
    local dest

    if [[ "" == "$3" || ("-f" = "$1" && "" = "$4") ]]; then
        echo "Usage: $0 -f hostfile source dest "
        echo "Usage: $0 hostlist source dest "
        echo "       Be sure to quote hostlist "
        return
    elif [ "-f" = "$1" ]; then
        hostlist=`cat $2`
        source=$3
        dest=$4
    else
        hostlist=$1
        source=$2
        dest=$3
    fi

    for host in $hostlist 
    do
        echolog "scp -rpC $source yahoo@$host:$dest"
        scp -rpC $source yahoo@$host:$dest
    done
}

function msshme {
    local hostlist
    local command

    if [[ "" == "$2" || ("-f" = "$1" && "" = "$3") ]]; then
        echo "Usage: $0 -f hostfile command "
        echo "Usage: $0 hostlist command "
        echo "       Be sure to quote hostlist "
        return
    elif [ "-f" = "$1" ]; then
        hostlist=`cat $2`
        command=$3
    else
        hostlist=$1
        command=$2
    fi

    for host in $hostlist 
    do
        echolog "ssh -x $host '$command'"
        ssh -x $host "$command"
    done
}


function pwdfile () {
    local f="$1"

    echo `pwd`"/$f"
}    