require "securerandom"

class BlockChain
	def initialize
		@chain = []
		@transaction = []
		@wallet = {}
	end

	def make_a_wallet
		new_wallet_address = SecureRandom.uuid
		@wallet[new_wallet_address]=1000
		@wallet
	end

	def trans(s,r,a)
		if @wallet[s].nil?
			"업는 지갑입니다."
		elsif @wallet[r].nil?
			"없는 지갑입니다."
		elsif @wallet[s].to_f < a.to_f
			"잔액이 부족합니다."
		else
			transaction = {
				"sender"=>s,
				"receiver"=>r,
				"amount"=>a
			}
			@transaction << transaction
			@wallet[s] = @wallet[s]-a.to_f
			@wallet[r] = @wallet[r]+a.to_f
			"거래 완료"
		end
	end

	def mining
		begin
			nonce=rand(1000000)
			hashed = Digest::SHA256.hexdigest(nonce.to_s)
		end while hashed[0..3] != "0000"
		block={
			"nonce"=>nonce,
			"index"=>all_chain.length + 1,
			"previous_address"=>Digest::SHA256.hexdigest(last_block.to_s),
			"time"=>Time.now,
			"transaction"=>@transaction
		}
		@transaction=[]
		@chain<<block
		nonce
	end

	def all_chain
		@chain
	end

	def last_block
		@chain[-1]
	end


end
