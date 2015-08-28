
class caapm::em::config inherits caapm {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

#  notify {"Running with em::config em_as_service = $em_as_service":}
#  notify {"Running with em::config wv_as_service = $wv_as_service":}


  if $em_as_service {

    file { $lic_file:
      ensure =>  present,
      source => "${puppet_src}/license/${lic_file}",
      path   => "${em_home}license/${lic_file}",
      owner  => $owner,
      group  => $group,
      mode   => $mode,
    }

    file {  "${em_home}/bin/Introscope_Enterprise_Manager.lax":
      ensure  =>  present,
      content => template("${module_name}/${version}/Introscope_Enterprise_Manager.lax"),
      owner   => $owner,
      group   => $group,
      mode    => $mode,
    }

# may need to manage an interim file.  copy over if there are major changes beyond plaintextpassword=true
    file { "${em_home}/config/IntroscopeEnterpriseManager.properties":
      ensure  => present,
      content => template("${module_name}/${version}/IntroscopeEnterpriseManager.properties"),
      owner   => $owner,
      group   => $group,
      mode    => $mode,
    }

    file { "${em_home}/config/apm-events-thresholds-config.xml":
      ensure =>  present,
      content => template("${module_name}/${version}/apm-events-thresholds-config.xml"),
      owner  => $owner,
      group  => $group,
      mode   => $mode,
    }

    file { "${em_home}/config/domains.xml":
      ensure =>  present,
      content => template("${module_name}/${version}/domains.xml"),
      owner  => $owner,
      group  => $group,
      mode   => $mode,
    }

    file { "${em_home}/config/tess-db-cfg.xml":
      ensure =>  present,
      content => template("${module_name}/${version}/tess-db-cfg.xml"),
      owner  => $owner,
      group  => $group,
      mode   => $mode,
    }

    file { "${em_home}/config/loadbalancing.xml":
      ensure  =>  present,
      content => template("${module_name}/${version}/loadbalancing.xml"),
      owner   => $owner,
      group   => $group,
      mode    => $mode,
    }

/*
  file_line { 'set_db_passwd':
    path  => "${em_home}/config/tess-db-cfg.xml",
    line  => "<property name=\"hibernate\.connection\.password\">${db_user_passwd}</property>",
    match => "<property name=\"hibernate\.connection\.password\">.*</property>",
  } ->

  file_line { 'reset_db_plaintextpasswords':
    path  => "${em_home}/config/tess-db-cfg.xml",
    line  => "<property name=\"plainTextPasswords\">true</property>",
    match => "<property name=\"plainTextPasswords\">false</property>",
  }
 */
    if $cluster_role == 'MOM' {
      if $webserver_dir == 'webapps' {
        file { "${em_home}/webapps/IntroscopeHelp.war":
          ensure  => present,
          force   => true,
          source  => "${puppet_src}/${version}/IntroscopeHelp.war",
          owner   => $owner,
          group   => $group,
        }
      } else {
        file { "${webserver_dir}/IntroscopeHelp.war":
          ensure  => present,
          force   => true,
          source  => "${puppet_src}/${version}/IntroscopeHelp.war",
          owner   => $owner,
          group   => $group,
          require => File[$webserver_dir],
        }
        file { $webserver_dir:
          ensure => 'directory',
          owner   => $owner,
          group   => $group,
          mode    => $mode,
        }
      }
    }
    /*
    if $cluster_role == 'MOM' {
      file { 'IntroscopeHelp.war':
        ensure  => present,
        force   => true,
#        path    => "${em_home}/webapps/IntroscopeHelp.war",
        path    => $webserver_dir ? {
          'webapps' => "${em_home}/webapps/IntroscopeHelp.war",
          default   => "${webserver_dir}/IntroscopeHelp.war",
        },
        source  => "${puppet_src}/${version}/IntroscopeHelp.war",
        owner   => $owner,
        group   => $group,
        require => $webserver_dir ? {
          'webapps' => File["${em_home}/webapps"],
          default   => File[$webserver_dir],
        },
      }

      file {"${em_home}/webapps":
        ensure => 'directory',
        owner   => $owner,
        group   => $group,
        mode    => $mode,
      }

    }
 */
# if channel2 enabled
#{
   # enable this section for keystore and truststore configuration management
/*
  java_ks { 'caapm_ca:truststore':
    ensure       => latest,
    certificate  => '/etc/puppet/ssl/certs/ca.pem',
    target       => 'internal/server/truststore',
    password     => 'puppet',
    trustcacerts => true,
  }

  java_ks { 'caapm_ca:keystore':
    ensure       => latest,
    certificate  => '/etc/puppet/ssl/certs/ca.pem',
    target       => 'internal/server/keystore',
    password     => 'puppet',
    trustcacerts => true,
  }
 */


/* use this code as of 27-Aug-2015

    if $pg_ssl {
      Openssl::Certificate::X509 <<| tag == "${cluster}-apmdb" |>>

      @@openssl::certificate::x509 { "${cluster}-${role}-${hostname}":
        ensure       => present,
        country      => 'AU',
        organization => 'diamond.org',
        commonname   => $fqdn,
        state        => 'VIC',
        locality     => 'Melbourne',
        unit         => 'Technology',
#        altnames     => ["DNS.1:*.${domain}"],
        email        => 'raul.dimar@gmail.com.au',
        days         => 3456,
        base_dir     => $ssl_dir,
        owner        => $owner,
        group        => $group,
        force        => false,
        cnf_tpl      => 'openssl/cert.cnf.erb',
        require      => File [$ssl_dir],
        tag          => "${cluster}-${role}"
      }

# how about the chain option?
# how about the private key?
# import the database certificate
      java_ks { "${cluster}-${role}-${hostname}":
        ensure       => latest,
        certificate  => "${ssl_dir}/${cluster}-${role}-${hostname}.crt",
        target       => $keystore,
        password     => $keystore_passwd,
        trustcacerts => true,
      }

      java_ks { "${cluster}-${role}:${keystore}":
        ensure       => latest,
        certificate  => "${ssl_dir}/${cluster}-${role}-${hostname}.crt",
        target       => $keystore,
        password     => $keystore_passwd,
        trustcacerts => true,
      }


    } */
  }

  if $wv_as_service {

    file { "${em_home}/config/IntroscopeWebView.properties":
      ensure  => present,
      content => template("${module_name}/${version}/IntroscopeWebView.properties"),
      owner   => $owner,
      group   => $group,
      mode    => $mode,
    }

    file {  "${em_home}/bin/Introscope_WebView.lax.lax":
      ensure  =>  present,
      content => template("${module_name}/${version}/Introscope_WebView.lax"),
      owner   => $owner,
      group   => $group,
      mode    => $mode,
    }

  }

}
