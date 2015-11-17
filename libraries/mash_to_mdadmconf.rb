def mash_to_mdadmconf(config)
  result=""

  if config.kind_of?(Hash)
    config.each do |k, v|
      case v
        when Hash,Mash
          result << "#{k} "
          v.each do |k1, v1|
            result << "#{k1}=#{v1} "
          end
          result << "\n"
        when Array
          v.each do |param|
            case param
              when Hash,Mash
                result << "#{k} "
                param.each do |k1, v1|
                  result << "#{k1}=#{v1} "
                end
                result << "\n"
              when String
                result << "#{k} #{param}\n"
            end
          end
        else
          result << "#{k} #{v}\n"
      end
    end
  end

  return result
end

# vim: ts=2 sw=2
