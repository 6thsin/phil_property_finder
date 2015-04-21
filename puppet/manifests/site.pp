exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

exec { 'apt-get install libmysqlclient-dev':
  command => '/usr/bin/apt-get install libmysqlclient-dev'
}

class { 'python':
  version     => 'system',
  pip         => true,
  dev         => true,
  virtualenv  => true
}

python::requirements {'/vagrant/requirements.txt':
  virtualenv  => '/python_environments/django_env',
  owner       => 'vagrant'
}

python::virtualenv { '/python_environments/django_env' :
  ensure       => present,
  version      => 'system',
  systempkgs   => true,
  distribute   => false,
  venv_dir     => '/python_environments/django_env',
  owner        => 'vagrant',
  group        => 'vagrant',
  timeout      => 0,
}

class { 'nodejs':
  version => 'stable'
}

package { 'grunt':
  provider => npm,
  require => Class['nodejs']
}

package { 'bower':
  provider => npm,
  require => Class['nodejs']
}

class { '::mysql::server':
  root_password           => '4ebce29effd5bb012bc313da0a8be9a7',
  remove_default_accounts => true,
#  override_options        => $override_options
}

mysql::db { 'real_estate':
  user     => 'real_estate',
  password => 'real_estate',
  host     => 'localhost',
#  grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'CREATE'],
}

#include git
include python
include nodejs
include '::mysql::server'