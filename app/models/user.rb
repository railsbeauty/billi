class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  attr_accessible :title, :body
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :on => :create
  validates_presence_of :username, :on => :create
  validates_uniqueness_of :email
  validates_uniqueness_of :username
	has_many :articles, :order => "created_at DESC"
	has_many :comments
  # Include default devise modules. Others available are:
  # :token_authenticatable, 
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
   :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  
end
