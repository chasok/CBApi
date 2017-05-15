class Book
	include DataMapper::Resource
	property :id,			Serial
	property :title,		String
	property :is_free,		Boolean
	property :price,		Float
	property :cover,		String
	property :created_at,	DateTime
	property :updated_at,	DateTime
	belongs_to	:user
end
