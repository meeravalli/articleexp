class Article < ActiveRecord::Base
  attr_accessible :name, :review
  validates :name, :review, presence: true 
  	 validates :name, length: { minimum: 2 }
  validates :review, length: { maximum: 200 }
  
end
