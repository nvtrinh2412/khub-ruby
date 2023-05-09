json.extract! question, :id, :text, :is_answered, :voted, :presentation_id, :user_id, :created_at, :updated_at
if question.user
  json.user do
    json.id question.user.id
    json.email question.user.email
  end
end
json.url question_url(question, format: :json)
