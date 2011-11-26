 class UserStory < ActiveRecord::Base
	validates_uniqueness_of :id_pivotal


	def  self.addStory(user_story)
		  @my_project = TrackR::Project.new(:project_id => 416129, :token => 'ca4c001cb4e08ebe7e62dc6d32a96f44')
		
	     @my_project.create_story(:story_type => 'epic', :current_state => 'start', 
		 	:description => 'a little test', :requested_by => 'test', 
		 	:owned_by => 'test', :name => 'test')
	end
end
