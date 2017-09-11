class YoutubeApi
    API_KEY = ENV["GOOGLE_API_KEY"]
    OAUTH_CLIENT_ID = ENV["GOOGLE_CLIENT_ID"]
    OAUTH_CLIENT_SECRET = ENV["GOOGLE_CLIENT_SECRET"]
    
    def initialize()
        initialize_secret_keys()
    end
    
    def get_video(id)
       Yt::Video.new id: id
    end
    
    def get_account(arg)
        
        if(arg.is_a?(User))
            google_token = arg.google_refresh_token
        elsif(arg.is_a?(String))
            google_token = arg
        else
            raise ArgumentError, "arg must be a User or a google_refresh_token"
        end
        
        Yt::Account.new refresh_token: google_token
    end
    
    def get_subscribed_channels(arg)
        account = get_account(arg)
        channels = account.subscribed_channels.map{ |channel| OpenStruct.new(
            thumbnail_url: channel.thumbnail_url,
            title: channel.title,
            video_count: channel.video_count,
            subscriber_count: channel.subscriber_count,
            subscriber_count_visible: channel.subscriber_count_visible?
        )}
        channels
    end
    
    private
        
        def initialize_secret_keys
            if(API_KEY)
                Yt.configuration.api_key = API_KEY 
            else
                raise LoadError, "Can't find environment variable 'GOOGLE_API_KEY'"
            end
            
            if(OAUTH_CLIENT_ID)
                Yt.configuration.client_id = OAUTH_CLIENT_ID
            else
                raise LoadError, "Can't find environment variable 'GOOGLE_CLIENT_ID'"
            end
            
            if(OAUTH_CLIENT_SECRET)
                Yt.configuration.client_secret = OAUTH_CLIENT_SECRET
            else 
                raise LoadError, "Can't find environment variable 'GOOGLE_CLIENT_SECRET'"
            end
        end
end