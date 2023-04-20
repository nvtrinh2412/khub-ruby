class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group
  enum role: {member: "member", owner: "owner" }, _default: :member
end
