class User < ApplicationRecord

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    # :recoverable,
    devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
         
    validates_uniqueness_of :uid, allow_blank: true, allow_nil: true
    
    
    has_many :user_channel_tag_relationships
    has_many :tags, -> { distinct }, through: :user_channel_tag_relationships
    has_many :channels, -> { distinct }, through: :user_channel_tag_relationships


    def tags_with_count
       tags.group('tags.title')
           .pluck('tags.title, count(user_channel_tag_rels.channel_id) as channel_count')
           .to_h
    end

    #  EXAMPLE OF RESPONSE FROM GOOGLE OMNIAUTH : (there isn't any email, so I worked around it)
    #  {
    #       "provider" => "google_oauth2",
    #             "uid" => "103535238159169432989",
    #           "info" => {
    #          "name" => "JeSuisUnCaill0u",
    #         "image" => "https://lh3.googleusercontent.com/-q1Smh9d8d0g/AAAAAAAAAAM/AAAAAAAAAAA/3YaY0XeTIPc/photo.jpg",
    #          "urls" => {
    #             "google" => "https://plus.google.com/103535238159169432989"
    #         }
    #     },
    #     "credentials" => {
    #                 "token" => "some_token",
    #         "refresh_token" => "some_refresh_token",
    #           "expires_at" => 1504962037,
    #               "expires" => true
    #     },
    #           "extra" => {
    #         "id_token" => "some_long_string",
    #          "id_info" => {
    #                 "azp" => "134945960714-np8li9doq6r3m2tnjb9hvonl7qs6hi52.apps.googleusercontent.com",
    #                 "aud" => "134945960714-np8li9doq6r3m2tnjb9hvonl7qs6hi52.apps.googleusercontent.com",
    #                 "sub" => "103535238159169432989",
    #             "at_hash" => "WDdR7nM2w3w6mUHh6dABdQ",
    #                 "iss" => "accounts.google.com",
    #                 "iat" => 1504958437,
    #                 "exp" => 1504962037
    #         },
    #         "raw_info" => {
    #               "kind" => "plus#personOpenIdConnect",
    #                 "sub" => "103535238159169432989",
    #               "name" => "JeSuisUnCaill0u",
    #             "profile" => "https://plus.google.com/103535238159169432989",
    #             "picture" => "https://lh3.googleusercontent.com/-q1Smh9d8d0g/AAAAAAAAAAM/AAAAAAAAAAA/3YaY0XeTIPc/photo.jpg?sz=50",
    #              "locale" => "en"
    #         }
    #     }
    # }
    def self.from_omniauth(access_token)
        info = access_token.info
        credentials = access_token.credentials
        uid = access_token.uid
        
        #find user by uid, or by email if uid not found
        user = User.where(uid: uid).first
        user = User.where(email: info['email']).first unless user
        
        # Create users if they don't exist, update it if it exists
        if user
            #update its google infos
            user.update(
                uid: uid,
                name: info['name'],
                google_token: credentials["token"],
                google_image_url: info['image']
            )
            #only updates these fields if they aren't empty, we don't want to override a previously given mail or refresh_token
            user.update(google_refresh_token: credentials['refresh_token']) if credentials["refresh_token"].present?
            user.update(email: info['email']) if info['email'].present?
        else
            #Create fake email from uid if missing
            email = info['email'] || "#{uid}@fakemail.com"
            #Create user
            user = User.create(
                uid: uid,
                name: info['name'],
                email: email,
                password: Devise.friendly_token[0,20],
                google_token: credentials["token"],
                google_refresh_token: credentials["refresh_token"],
                google_image_url: info['image']
            )
        end
        
        user
    end
  
end
