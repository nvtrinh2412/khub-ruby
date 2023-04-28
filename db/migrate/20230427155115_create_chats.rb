class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.text :text
      t.references :user, null: true , foreign_key: true
      t.belongs_to :presentation, null: false, foreign_key: true
      t.timestamps
    end
  end
end
