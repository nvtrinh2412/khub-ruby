class Group < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  # has_and_belongs_to_many :users
  has_many :memberships
  has_many :users ,through: :memberships , dependent: :destroy
end
