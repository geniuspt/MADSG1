 class UserStory < ActiveRecord::Base
	validates_uniqueness_of :id_pivotal

	#add an user_story to pivotal_tracker project 
	def  self.addStory(user_story)
		@project = Project.find(:first, :conditions => [ "pivotal_id = ? ",user_story.project_id])
		PivotalTracker::Client.token = @project.pivotal_token   
		@a_project = PivotalTracker::Project.find(user_story.project_id)

	    	aux = @a_project.stories.create(:story_type => user_story.story_type, :name => user_story.name, 
			:owned_by =>  user_story.owned_by, :requested_by => user_story.requested_by,
			:current_state => user_story.current_state, :description => user_story.description)
         	return aux
	end

	#update an user_story 
	def  self.editStory(user_story)
		@project = Project.find(:first, :conditions => [ "pivotal_id = ? ",user_story.project_id])
 		PivotalTracker::Client.token = @project.pivotal_token   
		@a_project = PivotalTracker::Project.find(@project.pivotal_id)

	    	aux = @a_project.stories.find(user_story.id_pivotal).update(:story_type => user_story.story_type, :name => user_story.name, 
			:owned_by =>  user_story.owned_by, :requested_by => user_story.requested_by,
			:current_state => user_story.current_state, :description => user_story.description)
		return aux.id
	end
	
end
