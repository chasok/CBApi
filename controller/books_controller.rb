# Fetch single book by id
get '/book/:id' do
	book = Book.get(params[:id])
	if book
		book.to_json
	else
		{ :error => "Book with that id does not exist" }.to_json
	end
end

# Fetch all books
get '/books' do
	MultiJson.dump({ :books => Book.all })
end

# Fetch all books for user
get '/books/:user_id' do
	user_id = params[:user_id]
	#user_id.to_json
	books = User.get(user_id).books
	MultiJson.dump({ :books => books })
end

# Create new book
post '/book' do
	params = MultiJson.load(request.body.read)
	book = Book.new(params)
	book.user = User.get(book.user_id)
	if book.save
		book.save
		book.to_json
	else
		MultiJson.dump({ :error => "Error creating book" })
	end
end

put '/book/:book_id' do
	# Check if book exists, first
	if Book.get(params[:book_id])
		# How do we want to handle updates?
		# Create new object, disassociate previous object?
		updated_book = Book.get(params[:book_id])

		json_params = MultiJson.load(request.body.read)

		#new_book = Book.new
		updated_book.name = json_params["name"]
		updated_book.contents = json_params["contents"]
		updated_book.notes = json_params["notes"]
		updated_book.checksum = json_params["checksum"]
		updated_book.version = updated_book.version + 1
		updated_book.user = User.get(json_params["user_id"])
		#updated_book.root_id = updated_book.root_id || updated_book.id

		if updated_book.save
			updated_book.to_json
		else
			MultiJson.dump({ :error => "Cannot update book"})
		end
	else
		MultiJson.dump({ :error => "Cannot find book with id: #{params[:id]}"})
	end
end

delete '/book/:book_id' do
	book = Book.get(params[:book_id])
	if book
		book.destroy
		MultiJson.dump({ :success => "Successfully destroyed book" })
	else
		MultiJson.dump({ :error => "Unable to destroy book" })
	end
end
