# Extensões da classe String
class String
  # verifica se é uma string do tipo boleano
  def boolean?
    true if !!self.match(/^(true|t|yes|y|1)$/i) or self.match(/^(false|f|no|n|0)$/i)
  end
  # converte para boleano
  def to_boolean
    if !!self.match(/^(true|t|yes|y|1)$/i)
      true
    elsif self.match(/^(false|f|no|n|0)$/i)
      false
    end
  end
end

require 'json'

module JSON
  def self.is_json?(foo)
    begin
      return false unless foo.is_a?(String)
      JSON.parse(foo).all?
    rescue JSON::ParserError
      false
    end
  end
end
