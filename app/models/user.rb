class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
  					format: { with: VALID_EMAIL_REGEX },
  					uniqueness: { case_sensitive: false }


  validates :name, 	length: { maximum: 50 },
  					uniqueness: { case_sensitive: false }

  validates :password,					length: { minimum: 6 },
  										presence: true
  validates :password_confirmation,		presence: true 

  before_save { |user| user.email = email.downcase }
end
