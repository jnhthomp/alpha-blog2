class Article < ApplicationRecord
  # Articles must have a user_id associated with them
  belongs_to :user
  
  # Set article and categories relationship
  # Each article can have several different categories
  # This is tracked in article_categories table
  has_many :article_categories
  has_many :categories, through: :article_categories
  
  # title validation
  validates :title, presence: true, length: {minimum: 6, maximum: 100}
  # description validation
  validates :description, presence: true, length: {minimum: 10, maximum:300}
end