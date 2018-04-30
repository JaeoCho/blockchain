require "sinatra"
require "sinatra/reloader"
require './block'

b=BlockChain.new

get '/' do
	"블럭리스트"
end

get '/mine' do
	b.mining.to_s		#.to_s: 숫자를 문자로& 시나트라는 꼭 문자로 반환
end