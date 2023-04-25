class AddRefSlidePresentation < ActiveRecord::Migration[7.0]
  def change
    add_reference :slides, :presentation, null: false, foreign_key: true
  end
end
