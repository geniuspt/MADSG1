class User < ActiveRecord::Base
	validates_presence_of :name
	has_many :comment
	has_many :state
end
