class User < ActiveRecord::Base
  has_many :tasks 
  has_and_belongs_to_many :projects
  has_many :comments
  has_secure_password
  validates :first_name, :last_name, presence: true, length: {in: 2...50}
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, uniqueness: {case_sensitive: false}, format: {with: email_regex} 
  validates :password, length: {minimum: 8}
end
