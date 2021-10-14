class User < ApplicationRecord
	include ActiveModel::Model
	
	has_many :posts
	
	validates :name, presence: true, uniqueness: true
	validates :email, presence: true, uniqueness: true
	validates :password, presence: true
	
	has_secure_password
end
