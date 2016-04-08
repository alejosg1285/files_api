class AddDescriptionToDataFile < ActiveRecord::Migration
  def change
    add_column :data_files, :description, :text
  end
end
