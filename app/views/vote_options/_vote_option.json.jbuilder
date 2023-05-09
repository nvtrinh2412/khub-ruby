json.extract! vote_option, :id, :text, :count, :slide_id, :created_at, :updated_at
json.url vote_option_url(vote_option, format: :json)
