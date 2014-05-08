class apache {
  package {'apache2':
    ensure: present,
  }

  file {'/etc/apache2/apache2.conf':
  	ensure => file,
  	owner => root,
  	group => root,
  	mode => 644,
  	soure => 'puppet:///modules/apache/apache2.conf'
  	require => Package['apache2']
  }
}