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
		transaction = {
			"sender"=>s,
			"receiver"=>r,
			"amount"=>a
		}
		@transaction << transaction
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
