require 'test_helper'

class LeSSLTest < ActiveSupport::TestCase
	test 'old LeSsl constant' do
		assert_nothing_raised do
			LeSsl
		end

		assert_equal LeSSL, LeSsl
	end
end
