define bash_user_skel(
    $user     = $title,
    $home_dir = false,
    $prompt   = false,
    $ps1      = false,
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

  if $prompt {
    $_ps1 = $ps1
  } else {
    if $user == "root" {
      $_ps1 = $bash_user_skel::ps1_root
    } else {
      $_ps1 = $bash_user_skel::ps1
    }
  }

  if $aliases {
    $_aliases = $aliases
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
