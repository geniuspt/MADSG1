 class UserStory < ActiveRecord::Base
	validates_uniqueness_of :id_pivotal


	def  self.addStory(user_story)
		  #@my_project = TrackR::Project.new(:project_id => 416129, :token => 'ca4c001cb4e08ebe7e62dc6d32a96f44')
		PivotalTracker::Client.token = 'ca4c001cb4e08ebe7e62dc6d32a96f44'
        @a_project = PivotalTracker::Project.find(416129)  
	    @a_project.stories.create(:story_type => 'feature', :name => 'test')
		 	return @a_project.stories.all
	end
end
