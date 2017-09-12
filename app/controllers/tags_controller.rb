class TagsController < ApplicationController
    
    before_action :set_tag, only: [:show]
    
    def create
        if(user_signed_in?)
            tag = Tag.find_or_create_by(title: tag_params['tag_title'])
            channel = Channel.find_or_create_by(uid: tag_params['channel_uid'])
        
            relation = UserChannelTagRelationship.new(tag: tag, channel: channel, user: current_user)
            if(relation.save)
                redirect_to user_path(current_user)
            else
                redirect_to user_path(current_user), alert: relation.errors.full_messages.join("\n")
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
           params.permit(:tag_title, :channel_uid)
        end
        
        def set_tag
            @tag = Tag.find(params[:id]) || Tag.find(params[:tag_id])
        end
end
