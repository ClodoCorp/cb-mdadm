node['mdadm']['packages'].each do |pkg|
  package pkg
end

service node['mdadm'['service_name'] do
  action :nothing
end

template node['mdadm']['config_file'] do
  source 'mdadm.conf.erb'
  owner 'root'
  mode 0644
  variables(
    :config => mash_to_mdadmconf(node['mdadm']['conf'])
  )
  action :create
  notifies :start, "service[#{node['mdadm']['service_name']}]", :immediately
  not_if { node['mdadm']['conf'].nil? || node['mdadm']['conf'].empty? }
end

unless node['mdadm']['devices'].nil? || node['mdadm']['devices'].empty?
  case node['mdadm']['devices']
  when Hash, Mash
    node['mdadm']['devices'].each do |name, values|
      next if values.nil? || values.empty?
      cmdline = values['options'].map do |k, v|
        if k.length > 1
          "--#{k} #{v}"
        else
          "-#{k} #{v}"
        end
      end
      cmdline = cmdline.join(' ')
      if values['options']['raid-devices'].nil?
        cmdline = "#{cmdline} --raid-devices=#{values['device'].count}"
      end
      if values['options']['metadata'].nil?
        cmdline = "#{cmdline} --metadata=1.2"
      end

      execute "mdadm --create /dev/md/#{name} #{cmdline} #{values['device'].join(' ')}" do
        command "mdadm --create #{name} #{cmdline} #{values['device'].join(' ')}"
        not_if { ::File.exist?("/dev/md/#{name}") }
      end
    end
  end
end
