class RenameTypeColumnInSlideTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :slides, :type, :sort
  end
end
