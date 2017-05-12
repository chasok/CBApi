class Activity
	include DataMapper::Resource
	property :id,			Serial
	property :from,			String
	property :to, 			String
	property :date,			Date
	property :sum,			Float
	belongs_to	:user
end