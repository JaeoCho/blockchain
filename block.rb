class BlockChain
	def mining
		begin
			nonce=rand(100000000)
			hashed = Digest::SHA256.hexdigest(nonce.to_s)
		end while hashed[0..3] != "0000"
		nonce
	end
end
