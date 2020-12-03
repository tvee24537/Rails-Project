class Category < ApplicationRecord
  has_many :games 

  validates :name, presence: true, uniqueness: true  # checks for name of category when making, does not allow repeat names

  scope :alpha, -> {order(:name)} # scope method for sorting alphabetical order

end
