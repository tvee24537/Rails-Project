class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :title, presence: true  
  validates :title, length: {maximum: 35}
  validates :content, length: {maximum: 250} 
  validates :stars, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than: 6} # numeric counter for rating from 0 to 5
  validates :game, uniqueness: { scope: :user, message: "has already been reviewed by you"  } # check for existing game of the same name and reviewed by user

end
