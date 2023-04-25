class Presentation < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :slides, dependent: :destroy
end
