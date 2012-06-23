# Class: nginx::package::debian
#
# This module manages NGINX package installation on debian based systems
#
# Parameters:
# 
# There are no default parameters for this class. 
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class nginx::package::debian {
	if ( ($operatingsystem == "Ubuntu") and ($operatingsystemrelease == 10.04) ) {

    # Patch taken from: http://stackoverflow.com/questions/7209489/how-to-work-with-puppet-dependencies-when-installing-nginx-1-0-5-on-ubuntu-11-04
    
    package { "nginx":
	    ensure => present,
	    require => Exec["nginx_repository"],
	  }

	  package { "python-software-properties":
	    ensure => installed,
	  }

		exec { "add-apt-repository ppa:nginx/stable && apt-get update":
			require => Package["python-software-properties"],
		  alias => "nginx_repository",
		  path => "/usr/bin",
		  creates => "/etc/apt/sources.list.d/nginx-stable-natty.list",
		}
  } else {
		package { 'nginx':
			ensure => present,
		}	
  }
}