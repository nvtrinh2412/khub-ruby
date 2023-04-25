class AddColumnToSlide < ActiveRecord::Migration[7.0]
  def change
    add_column :slides, :type, :string
    add_column :slides, :heading, :string
    add_column :slides, :sub_heading, :string
    add_column :slides, :description, :string
  end
end
