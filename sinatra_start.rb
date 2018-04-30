require "sinatra"
require "sinatra/reloader"
require './block'

b=BlockChain.new

get '/' do
	message=""
	b.all_chain.each do |a|
		message << "번호 : "+a["index"].to_s+"<br>"
		message << "Nonce값 : "+a["nonce"].to_s+"<br>"
		message << "앞 주소 : "+a["previous_address"].to_s+"<br>"
		message << "내 주소 : "+Digest::SHA256.hexdigest(a.to_s)+"<br>"
		message << "시간 : "+a["time"].to_s+"<br>"
		message << "<hr>"

	end
	message
end

get '/mine' do
	b.mining.to_s		#.to_s: 숫자를 문자로& 시나트라는 꼭 문자로 반환
end