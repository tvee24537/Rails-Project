class User < ApplicationRecord
  has_many :games
  has_many :reviews
  has_many :reviewed_games, through: :reviews, source: :game
  
  has_secure_password 
  
  validates :username, presence: true, uniqueness: true 
  validates :email, presence: true 
  
end
