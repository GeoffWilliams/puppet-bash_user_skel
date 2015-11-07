define bash_user_skel(
    $user     = $title,
    $home_dir = "/home/${title}",
    $prompt   = false,
    $ps1      = false,
) {
  include bash_user_skel::params

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

  file { "${home_dir}/.bash_logout":
    source => "${file_path}/.bash_logout",
  }

  file { "${home_dir}/.bashrc":
    source => "${file_path}/.bashrc",
  }

  file { "${home_dir}/.profile":
    source => "${file_path}/.profile",
  }

  file { "${home_dir}/.Xdefaults":
    source => "${file_path}/.Xdefaults",
  }

  file { "${home_dir}/.xscreensaver":
    source => "${file_path}/.xscreensaver",
  }

  file { "${home_dir}/.bash_custom": }

  file { "${home_dir}/.bash_system": 
    content => template(""),
  }

}
