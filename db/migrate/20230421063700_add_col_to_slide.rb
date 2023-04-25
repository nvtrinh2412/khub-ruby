class AddColToSlide < ActiveRecord::Migration[7.0]
  def change
      add_column :slides, :type, :string
  end
end
