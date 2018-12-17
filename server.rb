require 'sinatra'
require_relative 'movie'

#========================================= SETTINGS SECTION ============================================================
# Start application on custom port
if /[\D]+/.match(ARGV[0]) or ARGV[0].nil?
  set :port, 4567
else
  set :port, ARGV[0].to_i
end

set :bind => '0.0.0.0'
set :static => enable
set :views => "#{File.dirname(__FILE__)}/views"
set :public_folder => "#{File.dirname(__FILE__)}/public"
# If this line uncommented - sinatra doesn't show error messages
# disable :show_exceptions
# disable :raise_errors
#============================================END SETTINGS===============================================================

get '/' do
  movie = Movie.new.get_random_movie
  erb :root, :locals => {:movie => movie}
end

