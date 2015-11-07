# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# load puppet provided system settings
if [ -f ~/.bash_system ] ; then
    . ~/.bash_system
fi

# load any user supplied overrides
if [ -f ~/.bash_custom ] ; then
    . ~/.bash_custom
fi

