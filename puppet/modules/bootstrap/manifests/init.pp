class bootstrap {
	# Deal with notice about puppet group.
#	 group { 'puppet':
#		ensure => 'present'
#	}

  # Make sure we're getting the latest packages.
  exec { 'apt-get update':
    command => 'apt-get update'
  }
}