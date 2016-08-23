class DropUsersProjectsJoinTable < ActiveRecord::Migration
  def change
  	drop_table :users_projects
  end
end
