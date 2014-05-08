class apache_vhosts {
  # Sync custom envvar file.
  file {'/etc/apache2/sites-available/default':
  	ensure => file,
  	owner => root,
  	group => root,
  	mode => 644,
  	source => 'puppet:///modules/apache_vhosts/default',
  	notify => Service["apache2"]
  }

}