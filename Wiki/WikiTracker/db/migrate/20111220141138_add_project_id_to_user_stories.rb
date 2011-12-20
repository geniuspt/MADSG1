class AddProjectIdToUserStories < ActiveRecord::Migration
   def up
     add_column :user_stories, :project_id, :integer  	
  end

  def down
  end
end
