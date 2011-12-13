class Page < ActiveRecord::Base
  belongs_to :project
  validates_presence_of :name
  has_many :state
  has_many :comment
end
