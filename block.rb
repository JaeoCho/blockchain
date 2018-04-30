class BlockChain
	def initialize
		@chain = []
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
			"time"=>Time.now
		}
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
