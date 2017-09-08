class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :recoverable,
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
         
  validates_uniqueness_of :uid, allow_blank: true, allow_nil: true

  def self.from_omniauth(access_token)
    info = access_token.info
    credentials = access_token.credentials
    uid = access_token.uid
    
    user = User.where(uid: uid).first
    user = User.where(email: info['email']).first unless user

    # Create users to be created if they don't exist
    # stores the refresh token given only on first oauth connection
    unless user
        user = User.create(
            email: info['email'],
            password: Devise.friendly_token[0,20],
            google_refresh_token: credentials["refresh_token"],
            uid: uid
        )
    end
    
    #update its google infos
    user.update(
        name: info['name'],
        google_token: credentials["token"],
        google_image_url: info['image']
    )
    
    user
  end
  
end
