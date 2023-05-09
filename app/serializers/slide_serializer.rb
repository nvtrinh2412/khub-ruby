class SlideSerializer < ActiveModel::Serializer
  attributes :id, :question, :category, :sort,  :created_at, :updated_at
  has_many :vote_options
end
