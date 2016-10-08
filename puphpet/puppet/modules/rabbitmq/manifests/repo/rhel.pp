# Class: rabbitmq::repo::rhel
# Imports the gpg key if it doesn't already exist.
class rabbitmq::repo::rhel {

  if $rabbitmq::repos_ensure {

    $package_gpg_key = $rabbitmq::package_gpg_key

    Class['rabbitmq::repo::rhel'] -> Package<| title == 'rabbitmq-server' |>

    exec { "rpm --import ${package_gpg_key}":
      path   => ['/bin','/usr/bin','/sbin','/usr/sbin'],
      unless => 'rpm -q gpg-pubkey-6026dfca-573adfde 2>/dev/null',
    }
  }
}
