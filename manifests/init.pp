# bash_user_skel
# ==============
# Install customised dotfiles in user home directories
#
# Parameters
# ----------
# [*user*]
#   user we are managing files for.  Defaults to $title
# [*home_dir*]
#   home directory of user we are managing files for.  Defaults to /home/$user
# [*ps1*]
#   Provide a customised $PS1 prompt.  By default we have a coloured prompt
#   with user, host and directory in it.
# [*aliases*]
#   Provide an array of bash aliases to give to this user.  The default is to
#   give a nicer version of ls with colouring, file type and size
define bash_user_skel(
    $user     = $title,
    $home_dir = false,
    $ps1      = false,
    $aliases  = false,
) {
  include bash_user_skel::params

  if $home_dir {
    $_home_dir = $home_dir
  } else {
    if $user == "root" {
      $_home_dir = "/root"
    } else {
      $_home_dir = "/home/${user}"
    }
  }

  if $ps1 {
    $_ps1 = $ps1
  } else {
    if $user == "root" {
      $_ps1 = $bash_user_skel::params::ps1_root
    } else {
      $_ps1 = $bash_user_skel::params::ps1
    }
  }

  if $aliases {
    $_aliases = any2array($aliases)
  } else {
    $_aliases = $bash_user_skel::params::aliases
  }


  File {
    ensure => file,
    owner  => $user,
    group  => $user,
    mode   => "0644",
  }

  $file_path = "puppet:///modules/${module_name}/${os['family']}"

  # per-os files to copy
  case $os['family'] {
    "Debian": { 
      file { "${_home_dir}/.profile":
        source => "${file_path}/.profile",
      }

      file { "${_home_dir}/.Xdefaults":
        source => "${file_path}/.Xdefaults",
      }

      file { "${_home_dir}/.xscreensaver":
        source => "${file_path}/.xscreensaver",
      }
    }
    "RedHat": {
      file { "${_home_dir}/.bash_profile":
        source => "${file_path}/.bash_profile",
      }

    }
    default: { 
      notify { "${module_name} does not support ${os['family']}": }
    }
  }

  # common files for all platforms

  file { "${_home_dir}/.bash_logout":
    source => "${file_path}/.bash_logout",
  }

  file { "${_home_dir}/.bashrc":
    source => "${file_path}/.bashrc",
  }

  file { "${_home_dir}/.bash_custom": }

  file { "${_home_dir}/.bash_system": 
    content => template("${module_name}/.bash_system.erb"),
  }

}
