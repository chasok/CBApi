class Purchase
	include DataMapper::Resource
	property :id,			Serial
	property :price,		Float
	property :иought_at,	DateTime
	property :created_at,	DateTime
	property :updated_at,	DateTime

	belongs_to	:user
end