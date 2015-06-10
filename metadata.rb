name 'mdadm'
maintainer 'Vasiliy Tolstov'
maintainer_email 'v.tolstov@selfip.ru'
license 'CC0 1.0 Universal'
description 'Installs/Configures mdadm'
version '1.0.1'

%w(redhat centos fedora ubuntu debian sles).each do |os|
  supports os
end

recipe 'mdadm', 'Installs/Configures mdadm'
