class String
	def boolean?
		true if !!self.match(/^(true|t|yes|y|1)$/i) or self.match(/^(false|f|no|n|0)$/i)
	end
	def to_boolean
		if !!self.match(/^(true|t|yes|y|1)$/i)
			true
		elsif self.match(/^(false|f|no|n|0)$/i)
			false
		end
	end
end
