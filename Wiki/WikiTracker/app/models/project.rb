class Project < ActiveRecord::Base

	validates_presence_of :name
	has_many :page
	
	def self.getAllStoriesFromPivotal(id)
		PivotalTracker::Client.token = 'ca4c001cb4e08ebe7e62dc6d32a96f44'                 
		@a_project = PivotalTracker::Project.find(id) # find project with a given ID
		
		UserStory.delete_all
		Membership.delete_all
		@a_project.stories.all.each do |story|    	
			UserStory.create(:id_pivotal => story.id, :story_type => story.story_type, 
					:current_state => story.current_state, 
					:description => story.description, :requested_by => story.requested_by, 
					:owned_by => story.owned_by, :name => story.name, :created_at => story.created_at, 
					:accepted_at => story.accepted_at, :labels => story.labels )
		end
		
		@a_project.memberships.all.each do |member|    	
			Membership.create(:id_pivotal => member.id, :role => member.role, 
					:name => member.name, :email => member.email, :initials => member.initials)
		end
			
	end
end
