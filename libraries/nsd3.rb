
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
    data.each do |tag, value|
      next if value.nil? # skip nil values -> support deleting a presetted value
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
