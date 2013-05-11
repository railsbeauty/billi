class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me,:username, :provider, :uid
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

 def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
 
  user = User.where(:provider => auth.provider, :uid => auth.uid).first
  if user
    return user
  else
    registered_user = User.where(:email => auth.uid + "@twitter.com").first
    if registered_user
      return registered_user
    else
      user = User.create(username:auth.info.nickname,
        provider:auth.provider,
        uid:auth.uid,
        email:auth.uid+"@twitter.com",
        password:Devise.friendly_token[0,20],
      )
    end
  end
end

 def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(username:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            password:Devise.friendly_token[0,20],
                          )
      end
       
    end
  end

  def self.find_for_github_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(username:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            password:Devise.friendly_token[0,20],
                          )
      end
       
    end
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
     data = access_token.info
     user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
     if user
       return user
     else
       registered_user = User.where(:email => access_token.info.email).first
        if registered_user
         return registered_user
       else
         user = User.create(name: data["name"],
           provider:access_token.provider,
           email: data["email"],
           uid: access_token.uid ,
           password: Devise.friendly_token[0,20],
         )
       end
    end
   end

    def password_required?
     super && provider.blank?
    end
   
   def email_required?
    super && provider.blank?
   end

    def update_with_password(params, *options)
      if encrypted_password.blank?
        update_attributes(params, *options)
      else
        super
      end
    end

end
