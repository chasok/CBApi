# Fetch single card by id
get '/card/:id' do
	card = Card.get(params[:id])
	if card
		card.to_json
	else
		{ :error => "Card with that id does not exist" }.to_json
	end
end

# Fetch all cards for user
get '/cards/:user_id' do
	user_id = params[:user_id]
	#user_id.to_json
	cards = User.get(user_id).cards
	MultiJson.dump({ :cards => cards })
end

# Create new card
post '/card' do
	params = MultiJson.load(request.body.read)
	card = Card.new(params)
	card.user = User.get(card.user_id)
	if card.save
		card.save
		card.to_json
	else
		MultiJson.dump({ :error => "Error creating card" })
	end
end

put '/card/:card_id' do
	# Check if card exists, first
	if Card.get(params[:card_id])
		# How do we want to handle updates?
		# Create new object, disassociate previous object?
		updated_card = Card.get(params[:card_id])
		#old_card.status = "old"
		#old_card.save

		json_params = MultiJson.load(request.body.read)

		#new_card = Card.new
		updated_card.name = json_params["name"]
		updated_card.contents = json_params["contents"]
		updated_card.notes = json_params["notes"]
		updated_card.checksum = json_params["checksum"]
		updated_card.version = updated_card.version + 1
		updated_card.user = User.get(json_params["user_id"])
		#updated_card.root_id = old_card.root_id || old_card.id

		if updated_card.save
			updated_card.to_json
		else
			MultiJson.dump({ :error => "Cannot update card"})
		end
	else
		MultiJson.dump({ :error => "Cannot find card with id: #{params[:id]}"})
	end
end

delete '/card/:card_id' do
	card = Card.get(params[:card_id])
	if card
		card.destroy
		MultiJson.dump({ :success => "Successfully destroyed card" })
	else
		MultiJson.dump({ :error => "Unable to destroy card" })
	end
end