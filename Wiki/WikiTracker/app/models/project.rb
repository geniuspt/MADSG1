class Project < ActiveRecord::Base

	validates_presence_of :name
	has_many :page
	
	def self.getAllStoriesFromPivotal(id)
=begin		
    #project = Project.find(:first,:conditions => ["projectid = ?",id])
		#@my_project = TrackR::Project.new(:project_id => 376079, :token => 'ca4c001cb4e08ebe7e62dc6d32a96f44')
			
		#@my_project.stories.each do |story|
	UserStory.new(:id_pivotal => story.id, :story_type => story.story_type, 
	:current_state => story.current_state, 
	:description => story.description, :requested_by => story.requested_by, 
	:owned_by => story.owned_by, :name => story.name, :created_at => story.created_at, 
	:accepted_at => story.accepted_at, :labels => story.labels )
            #:updated_at => story.updated_at
        end
=end
    

PivotalTracker::Client.token = 'ca4c001cb4e08ebe7e62dc6d32a96f44'                 
#@projects = PivotalTracker::Project.all               # return all projects
@a_project = PivotalTracker::Project.find(376079) # find project with a given ID
@a_project.stories.all                      
@ola={}
@a_project.stories.all.each do |story|
    @ola=story
	UserStory.create(:id_pivotal => story.id, :story_type => story.story_type, 
	:current_state => story.current_state, 
	:description => story.description, :requested_by => story.requested_by, 
	:owned_by => story.owned_by, :name => story.name, :created_at => story.created_at, 
	:accepted_at => story.accepted_at, :labels => story.labels )
            #:updated_at => story.updated_at
        end
	return @ola
	end
end
