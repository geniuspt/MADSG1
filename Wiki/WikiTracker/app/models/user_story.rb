 class UserStory < ActiveRecord::Base
	validates_uniqueness_of :id_pivotal

	
	def  self.addStory(user_story)
		PivotalTracker::Client.token = 'ca4c001cb4e08ebe7e62dc6d32a96f44'
        	@a_project = PivotalTracker::Project.find(416129)  
	    	aux = @a_project.stories.create(:story_type => user_story.story_type, :name => user_story.name, :owned_by =>  user_story.owned_by,:requested_by => user_story.requested_by,:current_state => user_story.current_state, :description => user_story.description)
		return aux.id
	end
	
end
