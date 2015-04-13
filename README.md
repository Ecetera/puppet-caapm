#CA Application Performance Management (APM) Module

####Table of Contents
1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Installation and Setup](#Installation-and-Setup)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)
6. [Release Notes - Notes on the most recent updates to the module](#release-notes)



##Overview
This CA APM module manages both CA APM Workstation and Enterprise Managers on Windows, Redhat, AIX, and Solaris. 

This module does not configure firewall rules. Firewall rules will need to be configured separately in order to allow for correct operation of CA APM components. Additionally, this module does not supply CA APM installation media. Installation media will need to be acquired separately, and the module configured to use it.

Released under the terms of Apache 2 License.

##Module Description
The CA APM module manages both the CA APM Workstation and Enterprise Managers.  It will use configuration defaults on most occasions but may require some explicit configuration via heira or passed parameters.  

The module attempts to make installation and management of a CA APM components through Puppet.  It lso provides a means to manage CA APM Enterprise Manager configuration. 

Configuration of nodes can also be defined using [Puppet Roles and Profiles] (http://www.craigdunn.org/2012/05/239/)

##Limitations
For supported OS's refer to [CA APM Compatibility Guide] (http://www.ca.com/us/support/ca-support-online/product-content/status/compatibility-matrix/application-performance-management-compatibility-guide.aspx) and [Puppet Enterprise System Requirements] (https://docs.puppetlabs.com/pe/latest/install_system_requirements.html#operating-system)


##Installation and Setup
To begin using this module, use the Puppet Module Tool (PMT) from the command line to install this module:

```puppet
puppet module install ecetera-caapm
```

This will place the module into your primary module path if you do not utilize the --target-dir directive.

Once the module is in place, there is just a little setup needed.

First, you will need to place your downloaded CA APM installers into the files directory, <module_path>/caapm/files/. The files must be placed according to directory structure example given below.
 
The expected directory structure is:
```puppet
-- caapm
    |-- files
    |   |-- ${version}
    |   |   |-- ca-eula.txt
    |   |   |-- eula.txt
    |   |   |-- introscope${version}linuxAMD64.bin
    |   |   |-- introscope${version}windowsAMD64.exe
    |   |   |-- IntroscopeWorkstation${version}windows.exe
    |   |   |-- osgiPackages.v${version}.unix.tar
    |   |   `-- osgiPackages.v${version}.windows.zip
    |   `-- license
    |       `-- ${ipaddress}.em.lic
    `-- templates
        `-- ${version}
            `-- EnterpriseManager.ResponseFile.txt
            `-- Workstation.ResponseFile.txt
```

##Beginning with CA APM

To install the CA APM Workstation:
```puppet
class { "caapm::workstation":
  install_dir => "C:/Program Files (x86)/CA/APM/",
  version     => "9.1.4.0",
}
```

To install the CA APM Enterprise Manager (Standalone) with default settings:
```puppet
class { "caapm::em":
  install_dir => "D:/Apps/CA/APM/",
  version     => "9.1.4.0",
  features    => "Database,Enterprise Manager,WebView',
}
```

To install the CA APM Database (PostgreSQL) on Windows:
```puppet
class { "caapm::database":
  install_dir => "D:/Apps/CA/APM/PostgreSQL/",
}
```

To install the CA APM Enterprise Manager as a Collector role:
```puppet
class { "caapm::role::collector":}
```

##Basic management

Disable the Introscope Enterprise Manager service:
```puppet
class { "caapm::em ":}
  ensure => "stopped",
}
```

##Limitations

This module was developed for use on *nix puppet master with Windows and Unix puppet agents.

Please log tickets and issues at our [Module Issue Tracker]( https://github.com/Ecetera/puppet-caapm/issues).

##Extension management

```puppet
Planned - modules to allow the deployment of CA APM Extensions and PowerPacks including profiles and configuration
```

##Agent management
```puppet
Planned - modules to allow the deployment of CA APM Agents and manage the agent profiles and configuration
```

##Development

### Running tests

This project should contain test if not for rspec-puppet so fragile to get going.  Any help will be attributed.
This project contains tests for [rspec-puppet](http://rspec-puppet.com/) to verify functionality. For in-depth information please see their respective documentation.

Quickstart:

    gem install bundler
    bundle install
    bundle exec rake spec

##Copyright and License

Copyright (C) 2015 Raul Dimar / Ecetera

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
