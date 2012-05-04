class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :password, :password_confirmation
  
  validates_presence_of :password, :on => :create
  
  has_many :goals, :dependent => :destroy
  has_many :comments, :through => :goals
end
