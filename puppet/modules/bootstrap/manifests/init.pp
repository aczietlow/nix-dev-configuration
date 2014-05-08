class bootstrap {
	# Deal with notice about puppet group.
#	 group { 'puppet':
#		ensure => 'present'
#	}

  # Make sure we're getting the latest packages.
  exec { 'apt-get update':
    command => 'apt-get update'
  }

  # set defaults for file ownership/permissions
  File {
    owner => 'vagrant',
    group => 'vagrant',
    mode  => '0644',
  }
}