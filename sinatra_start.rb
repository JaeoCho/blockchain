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
		message << "거래 : "+a["transaction"].to_s+"<br>"
		message << "시간 : "+a["time"].to_s+"<br>"
		message << "<hr>"

	end
	message
end

get '/mine' do
	b.mining.to_s		#.to_s: 숫자를 문자로& 시나트라는 꼭 문자로 반환
end

get '/new_wallet' do
	b.make_a_wallet.to_s
end

get '/transaction' do
#	if params["sender"].nil?
#		"보내는 사람 정보가 없습니다."
#	elsif params["receiver"]
	"보내는 사람 : "+params["sender"] + "받는사람 : "+params["receiver"]+"거래내역 : "+params["amount"]
	b.trans(params["sender"],params["receiver"],params["amount"])
	"거래가 완료되었습니다."
end
#transcation?sender=a&receiver=b&amount=1.132