class PresentationSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at
  has_many :slides
end
