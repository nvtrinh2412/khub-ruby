class Presentation < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :slides, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :questions, dependent: :destroy
end
