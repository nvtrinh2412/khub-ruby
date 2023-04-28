class Chat < ApplicationRecord
  validates :text, presence: true
  belongs_to :sender, class_name: 'User', optional: true
  belongs_to :presentation

  def as_json(options={})
    super(options.merge({
      only: [:id, :text, :presentation_id, :created_at],
      include: { sender: { only: [:id, :email] } }
    }))
  end
end
