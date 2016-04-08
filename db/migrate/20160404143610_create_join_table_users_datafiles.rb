class CreateJoinTableUsersDatafiles < ActiveRecord::Migration
  def change
    create_join_table :users, :data_files
  end
end
