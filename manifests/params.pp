class bash_user_skel::params {

  # prompt colouring borrowed from https://wiki.archlinux.org/index.php/Color_Bash_Prompt

  # colourful prompt for normal users
  $ps1 = "\[\e[0;32m\]\u@\h:\[\e[m\]\[\e[1;34m\]\w\[\e[m\]\$ "

  # red prompt for root
  $ps1_root = "\[\e[0;31m\]\u@\h:\[\e[m\]\[\e[1;34m\]\w\[\e[m\]\[\e[0;31m\]# \[\e[m\]\[\e[0;32m\]"

  # ls with colour, size and file type indication
  $aliases = [
    "ls='ls --color=auto -shF'",
  ]
}
