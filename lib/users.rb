class User
	include DataMapper::Resource
	property :id,			Serial
	property :first_name,	String
	property :last_name,	String
	property :email,		String
	property :address,		String
	property :phone,		String
	property :password_hash,String
	property :is_active,	Boolean
	property :created_at,	DateTime
	property :updated_at,	DateTime
	property :api_token,	String

	def self.gen_api_token
		SecureRandom.uuid
	end

	def self.by_token(token)
		User.first(:api_token => token)
	end
end