class Comment
	include DataMapper::Resource
	property :id,			Serial
	property :text, 		String
	property :date,			DateTime
	belongs_to	:user
	belongs_to	:book
end