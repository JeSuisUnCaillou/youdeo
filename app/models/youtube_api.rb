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
        
        # vvv TOO SLOW !! vvv
        
        # map the results to retreive all infos right now, instead of in the views
        # channels = account.subscribed_channels.map{ |channel| OpenStruct.new(
        #     id: channel.id,
        #     thumbnail_url: channel.thumbnail_url,
        #     title: channel.title,
        #     video_count: channel.video_count,
        #     subscriber_count: channel.subscriber_count,
        #     subscriber_count_visible: channel.subscriber_count_visible?
        # )}
        
        # vvv FASTER vvv
        
        channels = get_all_subscribed_channels(account)
        
        channels.map{ |channel| 
            c = OpenStruct.new(
                uid: channel["snippet"]["resourceId"]["channelId"],
                thumbnail_url: channel["snippet"]["thumbnails"]["default"]["url"],
                title: channel["snippet"]["title"],
                video_count: channel["contentDetails"]["totalItemCount"]
            )
            [c.uid, c]
        }.to_h
        
    end
    
    private
    
        def get_all_subscribed_channels(account)
            get_subscribed_channels_page(account, nil)
        end
        
        def get_subscribed_channels_page(account, page_token)
            url = URI.parse "https://www.googleapis.com/youtube/v3/subscriptions?part=snippet%2CcontentDetails&channelId=#{account.channel.id}&maxResults=50&key=#{API_KEY}&pageToken=#{page_token}"
            res = Net::HTTP.get(url)
            json = ActiveSupport::JSON.decode(res)
            channels = json["items"]
            channels = channels + get_subscribed_channels_page(account, json["nextPageToken"]) if json["nextPageToken"].present?
            
            return channels
        end
        
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