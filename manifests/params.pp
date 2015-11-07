class bash_user_skel::params {

  # prompt colouring borrowed from https://wiki.archlinux.org/index.php/Color_Bash_Prompt

  # colourful prompt for normal users
  $ps1_user = "\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]"

  # red prompt for root
  $ps1_root = "\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\# \[\e[m\]\[\e[0;32m\]"

  $aliases = [
    "ls='ls --color=auto -shF'",
  ]
}
