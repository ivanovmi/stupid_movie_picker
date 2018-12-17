require 'thor'
require_relative 'movie'

class CLI < Thor
  desc "hello NAME", "Say hello to NAME"
  def hello(name)
    puts "Hello #{name}"
  end
  desc "db", "Update DB"
  def db
    Database.new
  end
end

CLI.start(ARGV)
