class Project < ActiveRecord::Base
	has_many :tasks
	has_and_belongs_to_many :users 
	has_many :comments, as: :commentable
	validates :name, presence: true 
	validates :start_date, date: {after: Proc.new {Time.now - 30.year},
								  before: Proc.new {Time.now + 50.year}}
	validates :end_date, date: {after: Proc.new {Time.now},
								before: Proc.new {Time.now + 70.year}}
end
