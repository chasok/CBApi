class Card
	include DataMapper::Resource
	property :id,			Serial
	property :type,			String
	property :number, 		String
	property :expiration,	String
	property :CVV,			Integer
	property :status,		String
	belongs_to	:user
end