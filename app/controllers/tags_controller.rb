class TagsController < ApplicationController
    def create
        # if(tag.save)
        #   redirect_to user_path(current_user)
        # else
        #   redirect_to user_path(current_user), alert: tag.errors.full_messages.join("\n")
        # end
        
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
    
    private
    
        def tag_params
           params.permit(:tag_title, :channel_uid)
        end
end
