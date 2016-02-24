module LeSSL
	class GenericError < StandardError; end
	class NoContactEmailError < GenericError; end
	class TermsNotAcceptedError < GenericError; end
	class NoPrivateKeyError < GenericError; end
	class PrivateKeyInvalidFormat < GenericError; end
	class UnauthorizedError < GenericError; end
end