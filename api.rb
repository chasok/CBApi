require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-timestamps'
require 'dm-migrations'
require 'dm-serializer/to_json'
require 'bcrypt'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/api.db")

before do
end

# load all libraries
configure do
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/controller")
  Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") { |lib| 
    require File.basename(lib, '.*') 
  }
  Dir.glob("#{File.dirname(__FILE__)}/controller/*.rb") { |con| 
    require File.basename(con, '.*') 
  }
end

DataMapper.auto_upgrade!

