node['mdadm']['packages'].each do |pkg|
  package pkg
end

service 'mdadm' do
  action :nothing
end

template '/etc/mdadm/mdadm.conf' do
  source 'mdadm.conf.erb'
  owner 'root'
  mode 0644
  variables(variables: node['mdadm']['conf'])
  action :create
  notifies :start, 'service[mdadm]', :delayed
  not_if { node['mdadm']['conf'].nil? || node['mdadm']['conf'].empty? }
end

unless node['mdadm']['devices'].nil? && node['mdadm']['devices'].empty?
  case node['mdadm']['devices']
  when Hash, Mash
    node['mdadm']['devices'].each do |name, values|
      next if values.nil? || values.empty?
      blkdevs = []
      devices = []
      Dir.foreach('/dev') do |f|
        n = File.realpath(File.join('/dev', f))
        blkdevs |= [n] if File.blockdev?(n)
      end
      patterns = values['devices']
      patterns.each do |pattern|
        pattern.each do |str, action|
          re = Regexp.new(str)
          blkdevs.each do |blkdev|
            re.match(blkdev) do
              case action
              when 'accept'
                devices |= [blkdev]
              when 'reject'
                devices.delete(blkdev)
              end
            end
          end
        end
      end
      cmdline = values['options'].map do |v, k|
        if v.length > 1
        then "--#{v} #{k}"
        else "-#{v} #{k}"
        end
      end
      ruby_block "mdadm --create /dev/md/#{name} #{cmdline} #{devices}" do
        block do
          mdadm = Mixlib::ShellOut.new("mdadm --create #{name} #{cmdline} #{devices}")
          puts mdadm.stdout
          puts mdadm.stderr
          mdadm.error!
        end
      end
    end
  end
end
