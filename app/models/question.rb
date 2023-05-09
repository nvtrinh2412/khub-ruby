class Question < ApplicationRecord
  belongs_to :presentation
  belongs_to :user , optional: true
  def as_json(options={})
    super(options.merge({
      only: [:id, :text, :presentation_id, :created_at],
      include: { user: { only: [:id, :email] } }
    }))
  end
end
