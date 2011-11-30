class Comment < ActiveRecord::Base
	validates_presence_of :body
	belongs_to :page
	belongs_to :user
end
