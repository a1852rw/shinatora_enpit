# -*- coding: utf-8 -*-

# テキストデータのJSON形式での保存と、そのデータの呼び出しを行うプログラムです
# JsonHelperはそれを支援します

require 'json'
require "date"
require 'singleton'
require File.expand_path(File.dirname(__FILE__) + '/JsonHelper.rb')


def makeNewTextFile()
    data = { "data" => [] }
    element = {
              JSON_KeyWord.id => "0",
              JSON_KeyWord.name => "システムコラボ",
              JSON_KeyWord.context => "グループワークの掲示板作りです！",
              JSON_KeyWord.date => Date.today()
            }
    data["data"].push(element);
    data = data.to_json
    File.open("./SaveData.txt","w")  { |f| f.write(data) }
end

def loadTextFile()
    File.open("./SaveData.txt", "r") do |f|
      while(line = f.gets)
        #puts "#{line}"
        class_variable_set(:@@j, JSON.parse(line))
      end
    end
end

def saveTextFile(newData)
    n = class_variable_get(:@@j)
    
    puts "saveTextFile!!!!!!"
    puts n
    puts newData
    
    n["data"].push(newData)
    n = n.to_json
    File.open("./SaveData.txt", "w") do |f|
      f.write(n)
    end
end

class J_Data
  include Singleton

  @@j = ""

  if File.file?("./SaveData.txt")
    loadTextFile()
  else
    makeNewTextFile()
    loadTextFile()
  end


  def self.getData
    return @@j
  end

  def self.putData(newData)
    saveTextFile(newData)
  end

end
