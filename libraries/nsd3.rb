
class Chef::Node
  def generate_nsd3_conf
    return nil if self['nsd3'].nil?
    lines = []
    %w(server).each do |sectionname|
      next if self['nsd3'][sectionname].nil?
      lines << '' if lines.length > 0
      lines << "#{sectionname}:"
      generate_nsd3_conf_section lines, self['nsd3'][sectionname]
    end
    lines << ''
    lines.join "\n"
  end
  
  private
  
  def generate_nsd3_conf_section(lines, data, prefix="\t")
    data.each do |tag, value_or_values|
      next if value_or_values.nil? # skip nil values -> support deleting a presetted value
      (value_or_values.kind_of?(Array) ? value_or_values : [ value_or_values ]).each do |value|
        if value.kind_of? TrueClass
          lines << "#{prefix}#{tag}: yes"
        elsif value.kind_of? FalseClass
          lines << "#{prefix}#{tag}: no"
        else
          lines << "#{prefix}#{tag}: #{value.to_s}"
        end
      end
    end
  end
end
