# puppet-ssp

## Table of Contents

1. [Description](#description)
2. [Requirements](#requirements)
3. [Usage](#usage)
    - [Basic usage](#basic-usage)
    - [Configure Self Service Password](#configure-self-service-password)
    - [Directory structure](#directory-structure)
4. [Reference](#reference)
5. [Documentation](#documentation)
6. [Development](#development)
    - [Contributing](#contributing)
7. [License](#license)

## Description

This is a Puppet module to install and manage [Self Service Password](https://ltb-project.org/documentation/self-service-password.html).
It is flexible to change and enable default Self Service Password functions for your location.


## Requirements

This module should work with all officially supported versions of Self Service Password.
The focus of this module is Self Service Password, so you should ensure that all additional components are available and ready to use:

* A webservice like Nginx or Apache, [puppetlabs/apache](https://github.com/puppetlabs/puppetlabs-apache) is recommended.
* A supported version of PHP (PHP-FPM is strongly recommended), [puppet/php](https://github.com/voxpupuli/puppet-php) is recommended.

## Usage

### Basic usage

One parameter is required to setup Self Service Password:


```puppet
class { 'ssp':
  version => '1.5.2'
}
```

If you want to change the smarty version while installation process, you have to change the parameter in hiera OS-familys, like Debian-family.yaml

```puppet
class { 'ssp':
  smarty_package_name => 'smarty3'
```

If you want to change the default folder path of smarty, you have to change the one parameter in init.pp

```puppet
class { 'ssp':
  smarty_path => '/usr/share/php/Smarty/Smarty.class.php'
}
```

The folder of the Self Service Password installation is derived from two parameters: `$installroot` and `$symlink_name`. Using different folders is simple:

```puppet
class { 'ssp':
  installroot  => '/opt',
  symlink_name => 'ssp',
}
```

In this example the Self Service Password installation will live in `/opt/self-service-password`, and this folder should be used as DocumentRoot for the webservice (and/or PHP-FPM). 

### Configure Self Service Password 

Please note, never change the default config.inc.php. It is not recommended. 
All entries in config can be changed in Self Service Password.

For example:

```puppet
class { 'ssp':
...
  config         => {
    ldap_url       => 'ldap://localhost',
    ldap_binddn    => 'cn=binduser',
    ldap_base      => 'dc=exaple,dc=com',
    pwd_min_length => 20,
    shadow_options => {
      update_shadowLastChange => true,
      shadow_expire_days      => -1,
    },
  },
}
```

### Directory structure

When using the module with default options... 

```puppet
class { 'ssp':
  installroot  => '/opt',
  symlink_name => 'ssp',
  version      => '1.5.2',
}
```

...the directory structure will look like this:


```
/
|-- opt/
|   |-- ssp@                                  # symlink to the current install dir (ssp-1.5.2)
|   |-- self-service-password                 # default install dir 
|   |-- self-service-password-1.5.2           # install dir for the current version
|   |   |-- conf/                             # default configuration folder
|   |       |-- config.inc.php                # default configuration for SSP (do not change, recommended)
|   |       |-- config.inc.local.php          # local config file to change settings in/for config.inc.php 
```

## Reference

Classes and parameters are documented in [REFERENCE.md](REFERENCE.md).


## Documentation

You can read more settings in the [Self Service Password Documentation](https://self-service-password.readthedocs.io/_/downloads/en/latest/pdf/)


## Development

### Contributing

Please use the GitHub issues functionality to report any bugs or requests for new features. Feel free to fork and submit pull requests for potential contributions.


## License

Copyright 2023 Daniel Renz
