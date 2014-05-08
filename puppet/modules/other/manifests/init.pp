class other {
	$packages = ['curl', 'emacs']
	package { $packages:
		ensure => present
	}

	package { 'vim':
	  ensure => present
	}

	file { '/home/vagrant/.vimrc':
		ensure => file,
		owner => vagrant,
		mode => 600,
		before => Package['vim'],
		source => 'puppet:///modules/other/vimrc'
	}
}