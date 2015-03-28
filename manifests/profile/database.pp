class caapm::profile::database { 
  class { "caapm::database":
    version => '9.1.4.0',
    install_dir => 'C:/Ecetera/Introscope9.1.4.0/',
    database => 'postgres',
    postgres_dir => 'C:/Ecetera/PostgreSQL-8.4/',
  } 
}