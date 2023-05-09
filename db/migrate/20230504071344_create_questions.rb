class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.text :text
      t.boolean :is_answered , default: false
      t.integer :voted , default: 0
      t.references :presentation, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true, default: nil
      t.timestamps
    end
  end
end
