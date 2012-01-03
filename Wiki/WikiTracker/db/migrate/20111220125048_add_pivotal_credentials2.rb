class AddPivotalCredentials2 < ActiveRecord::Migration
  def up
     add_column :projects, :pivotal_id, :integer  	
  end

  def down
  end
end
