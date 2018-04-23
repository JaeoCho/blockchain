require "sinatra"
require "sinatra/reloader"

get '/' do
	"block!!"
end

get '/mine' do
	"you mine a block"
end