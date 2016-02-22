require 'test_helper'

class LeSsl::ManagerTest < ActiveSupport::TestCase
	def private_key; @private_key ||= OpenSSL::PKey::RSA.new(2048); end
	def manager(skip_register=true); @manager ||= LeSsl::Manager.new(skip_register: skip_register, email: FFaker::Internet.free_email, private_key: private_key, agree_terms: true); end

	test 'valid initialization (without registering)' do
		assert_nothing_raised do
			manager
		end

		assert_equal_private_keys private_key, manager.send(:private_key)
	end

	test 'valid initialization with environment variables (but without registering)' do
		ENV['CERT_ACCOUNT_EMAIL'] = FFaker::Internet.email
		ENV['CERT_ACCOUNT_PRIVATE_KEY'] = private_key.to_s

		m = nil		# Scope

		assert_nothing_raised do
			m = LeSsl::Manager.new(skip_register: true, agree_terms: true)
		end

		assert_equal_private_keys private_key, m.send(:private_key)

		# Global variables!
		ENV['CERT_ACCOUNT_EMAIL'] = nil
		ENV['CERT_ACCOUNT_PRIVATE_KEY'] = nil
	end

	test 'invalid initialization without email' do
		assert_raise LeSsl::NoContactEmailError do
			LeSsl::Manager.new(agree_terms: true, private_key: private_key, skip_register: true)
		end
	end

	test 'invalid initialization without private_key' do
		assert_raise LeSsl::NoPrivateKeyError do
			LeSsl::Manager.new(agree_terms: true, email: FFaker::Internet.email, skip_register: true)
		end
	end

	test 'invalid initialization without agreeing terms' do
		assert_raise LeSsl::TermsNotAcceptedError do
			LeSsl::Manager.new(email: FFaker::Internet.email, private_key: private_key, skip_register: true)
		end
	end

	test 'client' do
		assert_kind_of Acme::Client, manager.send(:client)
	end

	test 'authorization with DNS' do
		challenge = manager(false).authorize_for_domain('example.org', challenge: :dns, skip_puts: true)

		assert_kind_of Acme::Client::Resources::Challenges::DNS01, challenge
	end

	private

	def assert_equal_private_keys(a, b)
		assert_equal a.to_s, b.to_s
	end
end
