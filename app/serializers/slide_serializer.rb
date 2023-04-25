class SlideSerializer < ActiveModel::Serializer
  attributes :id, :question, :category, :sort,  :created_at, :updated_at
end
