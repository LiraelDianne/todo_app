class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :comments, as: :commentable
  validates :name, presence: true
  validates :due_date, date: {after: Proc.new {Time.now},
  							  before: Proc.new {Time.now + 70.year}}
end
