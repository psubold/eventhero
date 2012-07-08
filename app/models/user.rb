class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
  					format: { with: VALID_EMAIL_REGEX },
  					uniqueness: { case_sensitive: false }


  validates :name, 	length: { maximum: 50 },
  					uniqueness: { case_sensitive: false }

  validates :password,					      length: { minimum: 6 }
  	
  validates :password_confirmation,		presence: true 

  before_save { |user| user.email = email.downcase }
  before_save { |user| user.name = user.email if user.name? == false }
  before_save :create_remember_token


  private

      def create_remember_token
        self.remember_token = SecureRandom.urlsafe_base64
      end
end
