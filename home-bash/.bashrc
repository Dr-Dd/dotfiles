# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "[$RETVAL]"
}

red=$(tput setaf 1)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
off=$(tput sgr0)

export QT_QPA_PLATFORMTHEME=gtk2

export PS1="\n┏\[\e[31m\]\`nonzero_return\`\[\e[m\]\[\e[32m\][\w]\[\e[m\]\[\e[33m\]\`parse_git_branch\`\[\e[m\]\n┗\[\e[34m\][λ]\[\e[m\] "

# NOTE: these aliases should be used for cli-ONLY commands, since all user-level commands will be run from dmenu, which only reads the 
#       $PATH (which is set with .local/bin in the front)
alias shutdown="sudo /sbin/shutdown"
alias pm-hibernate="sudo /usr/sbin/pm-hibernate"
alias pm-suspend="sudo /usr/sbin/pm-suspend"
alias pm-suspend-hybrid="sudo /usr/sbin/pm-suspend-hybrid"
alias cdma="cd /media/data/Music/Music\ Crate/Artists"

eval "$(thefuck --alias)"
