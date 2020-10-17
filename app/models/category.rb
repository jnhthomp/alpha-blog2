class Category < ApplicationRecord
  # Name validation
  validates :name, presence: true, length: { minimum: 3, maximum: 20 }
  validates_uniqueness_of :name

  # Set article and categories relationship
  # Each category can have several different articles
  # This is tracked in article_categories table
  has_many :article_categories
  has_many :articles, through: :article_categories
end