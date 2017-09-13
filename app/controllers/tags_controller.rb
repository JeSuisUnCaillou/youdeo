class TagsController < ApplicationController
    
    before_action :set_tag, only: [:show]
    
    def create
        if(user_signed_in?)
            error_messages = []
            tag_params['tag_titles'].each do |tag_title|
                tag = Tag.find_or_create_by(title: tag_title)
                channel = Channel.find_or_create_by(uid: tag_params['channel_uid'])
            
                relation = UserChannelTagRelationship.new(tag: tag, channel: channel, user: current_user)
                if(!relation.save)
                    error_messages += relation.errors.full_messages
                end
            end
            
            if(error_messages.empty?)
                redirect_to user_path(current_user)
            else
                redirect_to user_path(current_user), alert: error_messages.join("\n")
            end
            
        else
            redirect_to user_path(current_user), alert: "You must be signed in."
        end
    end
    
    def show
        channel_uids = @tag.channels.pluck(:uid)
        youtube_api = YoutubeApi.new
        @channels = youtube_api.get_channels(channel_uids)
        
        # /!\ Might be very long ?
        @videos = @channels.values.map{ |channel| 
            youtube_api.get_playlist_videos(channel.upload_playlist_id).values
        }.flatten
    end
    
    private
    
        def tag_params
            params.permit(:channel_uid, tag_titles: [])
        end
        
        def set_tag
            @tag = Tag.find(params[:id]) || Tag.find(params[:tag_id])
        end
end
