
class caapm::db::config inherits caapm {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

#  notify {"Running with db::config pg_as_service = $pg_as_service":}

  if $pg_ssl {

    file { $ssl_dir:
      ensure  => 'directory',
      owner   => $owner,
      group   => $group,
      mode    => $mode,
    }

    file_line { 'enable_ssl':
      path    => "${postgres_dir}/data/postgresql.conf",
      line    => "ssl = on                                                # enabled by Puppet to secure CA APM Database",
      match   => ".*ssl = .*$",
    }

    file_line { 'set_ssl_key_file':
      path    => "${postgres_dir}/data/postgresql.conf",
      line    => "ssl_key_file = '${ssl_dir}/${cluster}-${role}-${hostname}.key'                            # modified by Puppet to secure CA APM Database",
      match   => ".*ssl_key_file = .*$",
    }

    file_line { 'set_ssl_cert_file':
      path    => "${postgres_dir}/data/postgresql.conf",
      line    => "ssl_cert_file = '${ssl_dir}/${cluster}-${role}-${hostname}.crt'                           # modified by Puppet to secure CA APM Database",
      match   => ".*ssl_cert_file = .*$",
    }

    file_line { 'set_ssl_ciphers':
      path    => "${postgres_dir}/data/postgresql.conf",
      line    => "ssl_ciphers = '${ssl_ciphers}'                           # modified by Puppet to secure CA APM Database",
      match   => ".*ssl_ciphers = .*$",
    }

# review automatic data bindings to populate this via common.yaml
    @@openssl::certificate::x509 { "${cluster}-${role}-${hostname}":
      ensure       => present,
      country      => 'AU',
      organization => 'diamond.org',
      commonname   => $fqdn,
      state        => 'VIC',
      locality     => 'Melbourne',
      unit         => 'Technology',
#      altnames     => ["DNS.1:*.${domain}"],
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



    Openssl::Certificate::X509 <<| tag == "${cluster}-${role}" |>>

  }



}
