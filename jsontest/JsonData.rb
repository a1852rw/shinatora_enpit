# -*- coding: utf-8 -*-
require 'json'
require "date"
require 'singleton'
require File.expand_path(File.dirname(__FILE__) + '/JsonHelper.rb')


def makeNewTextFile()
    data = { "data" => [] }
    element = {
              JSON_KeyWord.id => 1,
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
    
   # puts "saveTextFile!!!!!!"
   # puts n
   # puts newData
    
    n["data"].push(newData)
    n = n.to_json
    File.open("./SaveData.txt", "w") do |f|
      f.write(n)
    end
end

def deleteMessage(delete_id)

  if !File.file?("./SaveData.txt")
    makeNewTextFile()
    loadTextFile()
    puts "deleteMessage return"
    return
  end

  loadTextFile() 

  n = class_variable_get(:@@j)
  key = JSON_KeyWord.id
  # puts "deleteMessage delete Id"
  # puts delete_id.to_i
  n["data"].each do |data|
    if (data[key] == delete_id.to_i)
      n["data"].delete(data)
      puts "break!"
      break
    end
  end

   # n["data"].each do |data|
   #  puts data
   # end

  n = n.to_json
  File.open("./SaveData.txt", "w") do |f|
   f.write(n)  
  end

  loadTextFile()
end

def findLastId()
  puts "findLastID BEGIN"
  n = class_variable_get(:@@j)
  count = n["data"].count
  if(count == 0)
    return 1
  end
  puts count
  puts n["data"][count-1]
  return n["data"][count-1][JSON_KeyWord.id]
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

  def self.popData(delete_id)
    deleteMessage(delete_id)
  end

  def self.getLastID()
    return findLastId()
  end
end
