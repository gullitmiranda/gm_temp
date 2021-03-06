class StandardizeNumbers
  def initialize(record, attributes)
    @attributes = attributes

    if @attributes.kind_of?(Array)
      @attributes.each do |attribute|
        unless record[attribute].nil?
          value = record[attribute]

          if !(value =~ /\.\d+\,/).nil?
            value = value.gsub(/[.,]/, ',' => '.', '.' => '_')
          elsif !(value =~ /\,\d+\./).nil?
            value = value.gsub(/\,/, '_')
          elsif !(value =~ /\,/).nil?
            value = value.gsub(/\,/, '.')
          end

          record[attribute] = value
        end
      end
    end
  end
end
