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
  devise :database_authenticatable, :registerable, :omniauthable,
   :recoverable, :rememberable, :trackable, :validatable

  def self.from_omniauth(auth)
   where(auth.slice(:provider, :uid)).first_or_create do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.username = auth.info.nickname
    end
  end
  
  def self.new_with_session(params, session)
    if session["devise.user_attritubes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
      user.attributes = params
      user.valid?
      end
    else
     super
    end
  end

  def password_required?
   super && provider.blank?
  end

end
