default['mdadm']['packages'] = value_for_platform(
  %w(alt ubuntu debian exherbo archlinux centos redhat suse fedora) => {
    'default' => ['mdadm']
  }
)


default['mdadm']['config_file'] = value_for_platform(
  %w(ubuntu debian exherbo archlinux centos redhat suse fedora) => {
    'default' => '/etc/mdadm/mdadm.conf'
  },
  %w(alt) => {
    'default' => '/etc/mdadm.conf'
  }
)

default['mdadm']['service_name'] = value_for_platform(
  %w(ubuntu debian) => {
    'default' => 'mdadm-raid'
  },
  %w(alt) => {
    'default' => 'mdadm'
  }
)
