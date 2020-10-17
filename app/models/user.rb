class User < ApplicationRecord
  # set email to lowercase before saving
  before_save {self.email = email.downcase} 
  
  # set user's articles dependence
  # will delete articles belonging to a user if the user is deleted
  has_many :articles, dependent: :destroy
  
  # username validation
  validates :username, presence: true, 
                      uniqueness: {case_sensitive: false}, 
                      length: {minimum: 3, maximum: 25}
                  
  # Email regex do not touch without testing on regex generator
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # Email validation
  validates :email, presence: true, 
                    uniqueness: {case_sensitive: false}, 
                    length: {maximum: 100},
                    format: {with: VALID_EMAIL_REGEX}

  # secure/hash password_digest attribute w/ bcrypt
  has_secure_password 
end