default['mdadm']['packages'] = value_for_platform(
  %w(alt ubuntu debian exherbo archlinux centos redhat suse fedora) => {
    'default' => ['mdadm']
  }
)
