#
# My Aliases (and simple functions)
#


## Useful commands
alias space="du -a ${HOME} | sort -nr |more"
alias when="date '+Date: %a %d %h 19%y%nTime: %T'"
alias	v="vgrind -t"
alias se=setup_env_and_leave 

function f () { finger -l ${1} | less -E; }
function watch () { tail -f $@ | filt; }
function gmore () { gzip -dc $@ | less -E; }
function gless () { gzip -dc $@ | less -E; }
function gcat ()  { gzip -dc $1; }
function bak () { cp ${1} ${1}.bak; }
function taeright () {
    tail -f /home/y/logs/yapache/error | perl -n -e "print ' ' x (80 - length(\$_)), \$_" -;
}
function copy_user () {
    ssh beta.edit /home/yahoo/bin/remote_dump_udb $1 > /tmp/$1.udb
    echo "edit_udb --force $1 /tmp/$1.udb"
    edit_udb --force $1 /tmp/$1.udb
    cat /tmp/$1.udb | ssh dev5.my /home/yahoo/bin/edit_udb --force $1 - 
    rm /tmp/$1.udb
}
    
function spl () { grep $1 /usr/share/dict/words; }
function psg () { ps -auxww | egrep $1; }
function hsg () { history | egrep $1; }
function psjg () { ps -jauxww | egrep $1; }

function cvslog () { cvs log ${1} | less; }

function pmm () {
    mozilla -remote "openurl(http://migration.yahoo.com/migration/prodigy?go=1&tstatus=0&debug=1&tfile=puser-${1})"
}
function pmc () {
    mozilla -remote "openurl(http://colorado.corp.yahoo.com/migration/prodigy?go=1&tstatus=0&debug=1&tfile=puser-${1})"
}

function pmmf () {
    mozilla -remote "openurl(http://migration.yahoo.com/migration/prodigy?go=1&tstatus=0&debug=1&tfile=${1})"
}
function pmcf () {
    mozilla -remote "openurl(http://colorado.corp.yahoo.com/migration/prodigy?go=1&tstatus=0&debug=1&tfile=${1})"
}

## Overloads & shortcuts
alias pd="/usr/local/bin/perl -de 1"
alias	la="ls -a"
alias ls="ls -F"
alias	ll="ls -l"
alias lla="ls -la"
alias start_xearth="/usr/X11R6/bin/xearth -pos 'fixed 42.33 -71.08' -rot -10  -nomarkers -nostar"
alias startx="ssh-agent startx"
alias	h="history"
alias	e="emacs"
alias	en="emacs -nw"
alias	more="less -E"
alias	g="gzip"
alias	gd="gzip -d"
alias	g="egrep"
alias j="jobs -l"
alias	[]="exit"
alias	][="exit"
alias ss="sudo /usr/local/bin/soundon"
alias cd="cd -P"
alias back="cd $OLDPWD"
alias v="vim"
alias changed="cvs -n update"
alias sab="ssh-agent /usr/local/bin/bash"
alias sad="ssh-add"
alias scp="scp -p"
alias kaf="killall -f" 
alias kaf9="killall -f -9" 
alias print_pods="find . -name "*.pm"  | perl -p -e 's|^\./||'  | perl -p -e 's|/|::|g' | perl -p -e 's|\.pm$||' |perl -p -e 's|\n$| |' | xargs -t -n 1 print_pod'"
## Messengar is broken on my box, but works from guggies... 
alias ym="xhost + guggie.corp; ssh guggie.corp 'export DISPLAY=colorado.corp.yahoo.com:0.0 ; ymessenger ' &"
## 
alias my_x2vnc="x2vnc -west -resurface -shared -edgewidth 2 wdr1.corp.yahoo.com:0"

## Printing
alias	lpa="lpr -Pa4-north"
alias	es="enscript -2r --margins=::50:50 -G"
alias	esp="enscript -2r --margins=::50:50 --pretty-print=perl -G"
alias	esp="enscript -2r --margins=::50:50 --pretty-print=java -G"
alias	ess="enscript -2r --margins=::50:50 --pretty-print=sql -G"
alias	esh="enscript -2r --margins=::50:50 --pretty-print=html -G"
alias	sc=". $HOME/.bashrc"
alias	k9="kill -9"
alias chp="chmod a+x *.pl"
alias kn="kill `ps -ef | grep netscape | grep -v grep | cut -d' ' -f7`"
alias xmlpretty="xmlpretty --PrettyWhiteNewline --PrettyWhiteIndent --CatchEmptyElement"
alias sub="grep '^sub'" 
  
# Going places...
alias atropos="ssh -l wdr1 atropos.corp.yahoo.com"
alias qa1="ssh -l wdr1 qa1.my.yahoo.com"
alias qa2="ssh -l wdr1 qa2.my.yahoo.com"
alias	amusive='ssh -l wdr1 amusive.com'
alias sf='sudo -u feed'
alias incoming1="xterm -bg red -e /usr/local/bin/ssh wdr1@incoming1.my.yahoo.com &"
alias incoming2="xterm -bg darkred -e /usr/local/bin/ssh wdr1@incoming2.my.yahoo.com &"
alias beta="ssh beta.my.yahoo.com"
alias beta.edit="ssh beta.edit.my.yahoo.com"
alias alpha="ssh alpha.my.yahoo.com"
alias alpha.edit="ssh alpha.edit.my.yahoo.com"

## CVS Settings
alias 'cvc'='cvs checkout' 
alias 'cvd'='cvs diff'
alias 'cvu'='cvs update'

## Yahoo things
alias cdmirrors='cd /net/produce/yahoo/mirrors'
alias cdmaillists='cd $HOME/dev/yahoo/network/email/etc/mail/lists'
alias flush_templates="sudo rm -Rf /home/idaho/user/*"
alias flush_loop='while [ 1 == 1 ]; do sleep 5; flush_templates ; done'
alias restart_ydfs="sudo -u yahoo /home/ydfs/restart"
alias kick_ydfs="sudo -u yahoo /home/ydfs/restart; sudo rm -Rf /home/idaho/user/*"
alias kick_yapache="sudo /home/y/bin/webctl restart"
alias lib="cd -P ~/dev/yahoo/libraries"
alias yut="cd -P ~/dev/yahoo/libraries/yut"
alias yax="cd -P ~/dev/yahoo/libraries/yax"
alias ydbs="cd -P ~/dev/yahoo/libraries/ydbs"
alias my="cd -P ~/dev/yahoo/my"
alias myp="cd -P ~/dev/yahoo/my/perl"
alias ydfs="cd -P ~/dev/yahoo/libraries/ydfs2"
alias ydfsi="cd /home/y/conf/ydfs/include"
alias ydfsl="cd /home/y/logs/ydfs/"
alias atoms="cd -P ~/dev/yahoo/libraries/ydfs2/atoms"
alias amy="cd -P ~/dev/yahoo/libraries/ydfs2/atoms/my"
alias aj="cd -P ~/dev/yahoo/libraries/ydfs2/atoms/jibba-jabber"
alias bridge="cd -P ~/dev/yahoo/libraries/ymybridge"
alias ymybridge="cd -P ~/dev/yahoo/libraries/ymybridge"
alias y="cd -P ~/dev/yahoo/"
alias me="cd /home/idaho/user/e9/02/"
export ME=/home/idaho/user/e9/02/
alias ida="cd ~/dev/yahoo/ida"
alias idaconfig="cd ~/dev/yahoo/idaconfig"
alias xerces="cd ~/dev/yahoo/external/xerces-c/samples"
alias yamon="cd /home/yamon/Yamon"
alias data="cd ~/dev/yahoo/data"
alias simple="cd ~/dev/yahoo/data/simple/"
alias simple_data="cd ~/dev/yahoo/data/simple/intl/us"
alias tail_apache="tail -f /home/y/logs/yapache/error"
alias feed="cd /home/feed"
alias itemplates="cd /home/idaho/templates"
alias iinclude="cd /home/idaho/include"
alias hy="cd /home/y"
alias sen="sudo emacs -nw"
alias dump_xml="$HOME/bin/dump_xml.pl"
alias tae="tail -f /home/y/logs/yapache/error"
alias ty="tail -f /home/y/logs/ydfs/ydfsSHM_error_log"
alias lynx_update_ycookies="grep yahoo.com $HOME/.mozilla/wdr1/ybstuzox.slt/cookies.txt  > $HOME/.lynx_cookies"


## Push commands
alias push_smbg="autopw push_multi.pl -f /home/feed/bin/process/xmlsmartbargain1.pl -m ~/.feed_servers -d /home/wdr1 -u wdr1 -c 'sudo cp xmlsmartbargain1.pl /home/feed/bin/process'" 
alias push_yplustxt="autopw push_multi.pl -f /home/feed/database/yplus.txt -m ~/.feed_servers -d /home/wdr1 -u wdr1 -c 'sudo cp yplus.txt /home/feed/database'" 
alias push_resizecfg="autopw push_multi.pl -f /home/feed/support/xmlplusfeed/resize.cfg -m ~/.feed_servers -d /home/wdr1 -u wdr1 -c 'sudo cp resize.cfg /home/feed/support/xmlplusfeed'" 

alias push_xmlplusfeed="autopw push_multi.pl -f /home/feed/bin/process/xmlplusfeed1.pl -m ~/.feed_servers -d /home/wdr1 -u wdr1 -c 'sudo cp xmlplusfeed1.pl /home/feed/bin/process'" 

alias push_plus_templates="autopw push_multi.pl -f '/home/feed/support/xmlplusfeed/templates/*' -m ~/.feed_servers -d /home/wdr1/tmp -u wdr1 -c 'sudo mv /home/wdr1/tmp/home/feed/support/xmlplusfeed/templates/*.tt /home/feed/support/xmlplusfeed/templates'"

alias push_pm="autopw push_multi.pl -f '/home/wdr1/dev/yahoo/idaconfig/partner_migration/partner_migrationConfig.so' -m migration.yahoo.com -d /tmp -u wdr1 -c 'sudo cp /home/y/lib/handlers/partner_migrationConfig.so /home/y/lib/handlers/partner_migrationConfig.so.bak; sudo cp /tmp/partner_migrationConfig.so /home/y/lib/handlers/partner_migrationConfig.so;  sudo webctl restart'"

# Notes
alias qn='cat - >> ~/notes/qn.`date +%y%m%d`'
alias qnl='cat ~/notes/qn.`date +%y%m%d`'

## xmms aliases
alias xn="xmms --fwd"
alias xp="xmms --rew"

## CVS Settings
alias amusivecvs="export CVS_RSH='ssh'; export CVSROOT=':ext:wdr1@amusive.com:/home/cvs'"
alias mgrepcvs="export CVS_RSH='ssh'; export CVSROOT=':ext:wdr1@cvs.mgrep.sourceforge.net:/cvsroot/mgrep'"


## Database shortcuts
alias dev="sqlplus petsmart/oradev@dev02b @$HOME/.sqlplus"
alias devl="sqlplus petsmart/oradev@dev02b @\!*"

## Unalias things
tmp=`alias -p | grep "^alias rm="`
if [ -n "$tmp" ]; then
    unalias rm;
fi

tmp=`alias -p | grep "^alias mv="`
if [ -n "$tmp" ]; then
    unalias mv
fi

##############################################################################
## Yahoo aliases
alias users_in_core='grep -i segmentation /home/apache/logs/error | grep -v signal  | perl -n -e "($u) = $_ =~ /; (Y=.*\&l=.*\/o)/; ($u2) = $u =~ /l=(.*)\/o/;  print \"$u\t$u2\n", `unscrambleLogin $u2`, \"\n\"\" | grep really'

alias giy='glimpseindex -B -b -t -H ~/dev/yahoo ~/dev/yahoo'
alias gy='glimpse -H ~/dev/yahoo'
alias gydev='glimpse -H /homes/ariel/wa/yahoo'
     
alias yfresh_update_my_local='scp qa1.my:/home/yfresh/My/scripts/* /home/yfresh/My/scripts/'

##############################################################################
## Project specific alias

## perfomrance statistics (ya-mon)
#alias pm="cd ~/perf_mon"
#alias rm_difficult_mails="rm $HOME/Mail/my-stats/difficult/*"
#alias rm_stats_mails="rm $HOME/Mail/my-stats/*"
#alias mydb="mysql --user=mystats --password=mystats mystats"
#alias myshow="mysqlshow --user=mystats --password=mystats mystats"

## Yplus

alias yptemplates="cd $HOME/dev/yahoo/my/templates"
alias ypincludes="cd /home/wdr1/Sandboxes/dev/yahoo/my/include/g/my/yplus"
alias ypchunks="cd /home/wdr1/Sandboxes/dev/yahoo/my/include/yplus"
alias yplib="cd /home/wdr1/Sandboxes/dev/yahoo/my/yplus/lib"
alias update_plus_feeds="pushd . ; cd /home/feed/archive2 ; rsync --size-only -v --rsh=ssh incoming2.my:/home/feed/archive/feed-xmlplusfeed1.20020[567]* . ; cd /home/feed/archive/ ;rsync --size-only -v --rsh=ssh incoming1.my:/home/feed/archive/feed-xmlplusfeed1.20020[567]* . ; cd /home/feed/support/xmlplusfeed/real_xml/ ; /home/feed/split.pl /home/feed/archive*/* ; popd"

## Yfresh
alias update_yfresh='rsync -C -r -u -pt -v --rsh=ssh /home/yfresh/ qa1.my:/home/yfresh'
alias yfresh="cd /home/yfresh"

##############################################################################
## Databus alias
alias db='cd /home/y/conf/databusRelay'
alias dbc='cd /home/y/var/databusRelay/out/conf'
alias dbl='cd /home/y/logs/databusRelay'
alias dbca='cd /home/y/var/databusRelay/cache'
alias mon='/home/y/conf/databusRelay/mon'

alias check='/home/y/bin/databusRelay-check'
alias start='/home/y/bin/databusRelay-start'
alias stop='/home/y/bin/databusRelay-stop'
alias y='sudo -u yahoo'
alias yb='sudo -u yahoo bash'


##############################################################################
## Partner Migration
alias home="mozilla -remote 'openurl(http://colorado.corp.yahoo.com/)'"

alias pm='cd ~/dev/yahoo/idaconfig/partner_migration/'

alias pmc_status="mozilla -remote 'openurl(http://colorado.corp.yahoo.com/migration/prodigy?go=status)'"
alias pmc_reset="mozilla -remote 'openurl(http://colorado.corp.yahoo.com/migration/prodigy?go=reset)'"
alias pmc_go="mozilla -remote 'openurl(http://colorado.corp.yahoo.com/migration/prodigy?go=1)'"
alias pmc_debug="mozilla -remote 'openurl(http://colorado.corp.yahoo.com/migration/prodigy?go=1&debug=10)'"

alias pmm_status="mozilla -remote 'openurl(http://migration.yahoo.com/migration/prodigy?go=status)'"
alias pmm_reset="mozilla -remote 'openurl(http://migration.yahoo.com/migration/prodigy?go=reset)'"
alias pmm_go="mozilla -remote 'openurl(http://migration.yahoo.com/migration/prodigy?go=1)'"
alias pmm_debug="mozilla -remote 'openurl(http://migration.yahoo.com/migration/prodigy?go=1&debug=10)'"

alias check_errors="monitor_error_logs.pl -g '(update|migrate)' -f edit.member"

##############################################################################
## YDFS2
alias ytest="flush_templates && mozilla -remote 'openurl(http://colorado.corp.yahoo.com/ydfs2/test.html)'"
alias yltest="flush_templates && lynx -dump http://colorado.corp.yahoo.com/ydfs2/test.html"


alias cycle="ydfs && cmake && cd atoms/jibba-jabber && cmake && cd ../my && cmake && bridge; rm perl/bridge.so; cmake && kick_ydfs && sleep 1 && ytest"

alias lcycle="ydfs && cmake && bridge && cmake && kick_ydfs && sleep 4 && yltest"


alias pwiki="links http://wdr1.com/cgi-bin/pwiki.pl"
