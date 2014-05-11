class apache {
  package {'apache2':
    ensure => present,
    before => [
      File["/etc/apache2/apache2.conf"],
      File["/etc/apache2/envvars"]
    ]
  }

  # Sync custom apache2.conf
  file {'/etc/apache2/apache2.conf':
  	ensure => file,
  	owner => root,
  	group => root,
  	mode => 644,
  	source => 'puppet:///modules/apache/apache2.conf',
  	notify => Service["apache2"]
  }

  # Sync custom envvar file.
  file {'/etc/apache2/envvars':
  	ensure => file,
  	owner => root,
  	group => root,
  	mode => 644,
  	source => 'puppet:///modules/apache/envvars',
  	notify => Service["apache2"]
  }

  # ensures that mode_rewrite is loaded and modifies the default configuration file
  file { "/etc/apache2/mods-enabled/rewrite.load":
    ensure => link,
    target => "/etc/apache2/mods-available/rewrite.load",
    require => Package["apache2"],
    notify => Service["apache2"]
  }

  # starts the apache2 service once the packages installed, and monitors changes to its configuration files and reloads if nesessary
  service { "apache2":
    ensure => running,
    require => Package["apache2"],
    subscribe => [
      File["/etc/apache2/mods-enabled/rewrite.load"],
      File["/etc/apache2/apache2.conf"],
      File["/etc/apache2/envvars"]
    ],
  }

  #Remove the conf files in the conf.d directory except the charset.
  tidy { 'tidy_apache_conf':
    path    => '/etc/apache2/conf.d/',
    age => 1s,
    recurse => 1,
    backup  => true,
    matches => [
      'localized-error-pages',
  	  'other-vhosts-access-log',
  	  'security'
    ],
    require => Package['apache2']
  }
}