json.extract! chat, :id, :text, :presentation_id, :created_at
if chat.sender
  json.sender do
    json.id chat.sender.id
    json.email chat.sender.email
  end
end
