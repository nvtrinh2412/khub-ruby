class User < ApplicationRecord
  before_save { self.email = email.downcase  }
  validates :username, presence: true, length: { maximum: 50 },uniqueness: {case_sensitive: false}
  validates :email,  presence: true, uniqueness: {case_sensitive: false}, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_secure_password
  # has_and_belongs_to_many :groups
  has_many :memberships
  has_many :groups , through: :memberships, dependent: :destroy
end
