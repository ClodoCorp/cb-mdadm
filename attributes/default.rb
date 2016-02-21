default['mdadm']['packages'] = value_for_platform(
  %w(ubuntu debian exherbo archlinux centos redhat suse fedora alt) => {
    'default' => ['mdadm']
  }
)
