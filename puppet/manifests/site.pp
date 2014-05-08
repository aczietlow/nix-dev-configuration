# default path so we don't have to specify the full path on each exec.
Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

# Create a new run stage to ensure bootstrap runs first.
stage { 'pre':
	before => Stage['main']
}

class { 'bootstrap':
	stage => 'pre'
}

include bootstrap, other, apache, apache_vhosts