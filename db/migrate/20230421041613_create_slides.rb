class CreateSlides < ActiveRecord::Migration[7.0]
  def change
    create_table :slides do |t|
      t.string :question
      t.string :category
      t.timestamps
    end
  end
end
