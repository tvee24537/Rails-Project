class Game < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :reviews
  has_many :users, through: :reviews
  
  validates :name, presence: true, uniqueness: true
  validates :release_date, presence: true  
  validate :not_a_duplicate 

  scope :order_by_rating, -> {left_joins(:reviews).group(:id).order('avg(stars) desc')} # scope method, ordering reviews by rating given
  scope :most_popular, -> {left_joins(:reviews).group(:id).order('count(reviews.id) desc').limit(3)} # scope method, ordering review by amount

  def self.alpha # order by alphabets 
    order(:name) 
  end
  # attributes for category
  def category_attributes=(attributes)
    self.category = Category.find_or_create_by(attributes) if !attributes['name'].empty?
    self.category 
  end

  def not_a_duplicate
    # if there is already a game with this name and release date
    game = Game.find_by(name: name, release_date: release_date) 
    if !!game && game != self
      errors.add(:name, 'has already been added for that release date')
    end
  end 
  
  def category_name
    category.try(:name)
  end
    
  def name_and_category
    "#{name} - #{category.try(:name)}"
  end
 
end
