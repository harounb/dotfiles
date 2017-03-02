# Not sure if I still need this
# SSH_ENV=$HOME/.ssh/environment
  
# start the ssh-agent
# function start_agent {
#     echo "Initializing new SSH agent..."
#     # spawn ssh-agent
#     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
#     echo succeeded
#     chmod 600 "${SSH_ENV}"
#     . "${SSH_ENV}" > /dev/null
#     /usr/bin/ssh-add
# }
  
# if [ -f "${SSH_ENV}" ]; then
#      . "${SSH_ENV}" > /dev/null
# 	 ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || 
# {
# 	    start_agent;
# 	}
# else
#     start_agent;
# fi

if test -f /etc/profile.d/git-sdk.sh
then
	TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
	TITLEPREFIX=$MSYSTEM
fi

PS1='\[\033]0;$TITLEPREFIX:${PWD//[^[:ascii:]]/?}\007\]' # set window title
# PS1="$PS1"'\n'                 # new line
# PS1="$PS1"'\[\033[32m\]'       # change to green
# PS1="$PS1"'\u '             # user@host<space>
PS1="$PS1"'\[\033[33m\]'       # change to brownish yellow
PS1="$PS1"'📁 \w'                 # current working directory
if test -z "$WINELOADERNOEXEC"
then
	GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
	COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
	COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
	COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
	if test -f "$COMPLETION_PATH/git-prompt.sh"
	then
		. "$COMPLETION_PATH/git-completion.bash"
		. "$COMPLETION_PATH/git-prompt.sh"
		PS1="$PS1"'\[\033[36m\]'  # change color to cyan
		PS1="$PS1"'`__git_ps1`'   # bash function
	fi
fi
PS1="$PS1"'\[\033[0m\]'        # change color
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'$ '                 # prompt: always $
MSYS2_PS1="$PS1"               # for detection by MSYS2 SDK's bash.basrc
