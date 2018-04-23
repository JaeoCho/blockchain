require "sinatra"
require "sinatra/reloader"

get '/' do
	"block!!"
end

get '/blah' do
	"you mine a block"
end