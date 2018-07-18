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

class JSON_KeyWord
  
  def self.id
    return "id"
  end
  
  def self.name
    return "name"
  end
  
  def self.context
    return "context"
  end
  
  def self.date
    return "date"
  end
  
end
