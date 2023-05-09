class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :text, :is_answered, :voted
  belongs_to :presentation
  belongs_to :user , optional: true
end
