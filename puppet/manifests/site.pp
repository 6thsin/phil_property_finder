exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
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

#include git
include python
include nodejs