require "sinatra"
require "sinatra/reloader"

get '/' do
	"block!!"
end

get '/blah_12345' do
	"you mine a block"
end