class VoteOptionSerializer < ActiveModel::Serializer
  attributes :id, :text, :count
  belongs_to :slide
end
