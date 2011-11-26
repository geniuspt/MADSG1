class Project < ActiveRecord::Base

	validates_presence_of :name
	has_many :page
	
	def self.getAllStoriesFromPivotal(id)
		#project = Project.find(:first,:conditions => ["projectid = ?",id])
		@my_project = TrackR::Project.new(:project_id => 376079, :token => 'ca4c001cb4e08ebe7e62dc6d32a96f44')
			
		@my_project.stories.each do |story|
            UserStory.create(:id_pivotal => story.id, :story_type => story.story_type, 
			:estimate => story.estimate, :current_state => story.current_state, 
			:description => story.description, :requested_by => story.requested_by, 
			:owned_by => story.owned_by, :name => story.name, :created_at => story.created_at, 
			:accepted_at => story.accepted_at, :labels => story.labels, :project_id => 376079)
            #:updated_at => story.updated_at
        end
	
	
	end

end
