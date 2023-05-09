class Slide < ApplicationRecord
  belongs_to :presentation
  has_many :vote_options, dependent: :destroy
end
