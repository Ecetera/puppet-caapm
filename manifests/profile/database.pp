class caapm::profile::database { 
  class { "caapm::database":
    version => '9.6.0.0',
    user_install_dir => 'C:/Ecetera/Introscope/',
    database => 'postgres',
    postgres_dir => 'C:/Ecetera/PostgreSQL/',
    config_as_service => false,
    config_wv_as_service => false,
  } 
}