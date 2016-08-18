module LeSSL
	class DNS
		def initialize(nameservers=['8.8.8.8', '8.8.4.4'])
			@dns = Resolv::DNS.new(nameserver: nameservers)
		end

		# Checks if the TXT record
		# for a domain is valid.
		def challenge_record_valid?(domain, key)
			record = challenge_record(domain)
			return record && record.data == key
		end

		def challenge_record_invalid?(domain, key)
			return !challenge_record_valid?(domain, key)
		end

		private

		# @return [Resolv::DNS::Resource::IN::TXT, nil]
		#   The challenge record for a defined domain.
		#   If no challenge present nil is returned.
		def challenge_record(domain)
			@dns.getresource("_acme-challenge.#{domain}", Resolv::DNS::Resource::IN::TXT)
		rescue Resolv::ResolvError => e
			nil  # Return silently
		end
	end
end