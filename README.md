# bash_user_skel
https://travis-ci.org/GeoffWilliams/puppet-bash_user_skel.svg

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with bash_user_skel](#setup)
    * [What bash_user_skel affects](#what-bash_user_skel-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with bash_user_skel](#beginning-with-bash_user_skel)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Populate a sysadmin's home directory with a set of consistent luxury bash configuration files.  Files content is determined by this module rather then copying files already on the target system to ensure consistency.

## Module Description
Provides:
* A pretty shell prompt for regular users and a red one for anyone logging in as root
* A colourful `ls` command showing sizes
* Enforced consistency (replaces `~/.bashrc`)
* Extension point for local changes (`~/.bash_custom`)
* An easy way of fully setting up a local user with Puppet
* Method to distribute custom aliases and prompts to required users


## Setup

### What bash_user_skel affects

* Creates various dotfiles in the the user home directory, mirroring those in `/etc/skel`
* Since `~/.bashrc` is managed by Puppet, we provide a means for users to add custom unmanaged code to their shell session by editing `~/.bash_custom`


### Beginning with bash_user_skel

The module provides a single defined resource type `bash_user_skel` which needs to be applied for each user you want configure.  If your happy to accept the default prompt and alias settings, all you need is:

```puppet
bash_user_skel { "username": }
```

Where `username` is the username you wish to apply the settings to.  If you have a small list of users its probably easiest to keep this in hiera and feed the list to the defined resource type, otherwise for larger lists you could look towards a facter based solution or integration with LDAP.

The default settings assume a home directory under `/home`.

## Usage

In cases where you would like to supply different prompts and aliases, or your user has an unusual home directory, you can configure this via the `bash_user_skel` resource's parameters:

```puppet
bash_user_skel( "frank_furter":
    $home_dir = "/exports/users/frank_furter",
    $ps1      = "$",
    $aliases  = [
     "ll='/bin/ls -l'",
     "ld='/bin/ls -ld'",
    ],
) {
```

In this case, we have a custom home directory, a simplified prompt of just `$` and a couple of aliases for `ls`.

## Reference

* `bash_user_skel` - Install customised dotfiles in user home directories

## Limitations

Only Debian and Ubuntu support right now.  Should be easy to add other Unix like OS's

## Development

PRs accepted
