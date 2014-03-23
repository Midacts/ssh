# == Class
#
# ssh
#
# == Synopsis
#
# This class is used for managing Debian's ssh with Puppet. Specifically the 
# ssh package, and the sshd_config and issue.net files.
#
# == Author
#
# John McCarthy <midactsmystery@gmail.com>
#
# - http://www.midactstech.blogspot.com -
# - https://www.github.com/Midacts -
#
# == Date
#
# 23rd of March, 2014
#
# -- Version 1.0 --
#
class ssh {

  package { 'ssh':
    ensure	=> latest,
  }

  file { '/etc/ssh/sshd_config':
    ensure	=> present,
    content	=> template('ssh/sshd_config.erb'),
    owner	=> root,
    group	=> root,
    mode	=> 644,
    require	=> Package['ssh'],
  }

  file { '/etc/issue.net':
    ensure	=> present,
    content	=> template('ssh/issue.net.erb'),
    owner	=> root,
    group	=> root,
    mode	=> 644,
    require	=> File['/etc/ssh/sshd_config'],
  }

  service { 'ssh':
    enable	=> true,
    ensure	=> true,
    subscribe	=> [File['/etc/ssh/sshd_config'], File['/etc/issue.net']],
  }

}
