
class Chef::Node
  def generate_nsd3_conf
    return nil if self['nsd3'].nil?
    lines = []
    
    lines << ''    
    lines << 'server:'
    generate_nsd3_conf_section lines, self['nsd3']['server']
    
    self['nsd3']['zones'].each do |zone_name,zone_data|
      lines << ''
      lines << 'zone:'
      generate_nsd3_conf_section lines, {'name' => zone_name}.merge(zone_data)
    end
    
    self['nsd3']['keys'].each do |key_name,key_data|
      lines << ''
      lines << 'key:'
      generate_nsd3_conf_section lines, {'name' => key_name}.merge(key_data)
    end
    
    lines << ''
    lines.join "\n"
  end
  
  private
  
  def generate_nsd3_conf_section(lines, data, prefix="\t")
    data.each do |tag, value_or_values|
      # Does not work as intended because deep merge ignores nil values always so no reset possible
      next if value_or_values.nil? # skip nil values -> support deleting a presetted value
      (value_or_values.kind_of?(Array) ? value_or_values : [ value_or_values ]).each do |value|
        if value.kind_of? TrueClass
          lines << "#{prefix}#{tag}: yes"
        elsif value.kind_of? FalseClass
          lines << "#{prefix}#{tag}: no"
        elsif value == ''
          next
        else
          lines << "#{prefix}#{tag}: #{value.to_s}"
        end
      end
    end
  end
end
