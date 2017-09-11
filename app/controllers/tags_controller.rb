class TagsController < ApplicationController
    def create
        tag = Tag.new(tag_params)
        if(tag.save)
           redirect_to user_path(current_user)
        else
           redirect_to user_path(current_user), alert: tag.errors.full_messages.join("\n")
        end
    end
    
    private
    
        def tag_params
           params.require(:tag).permit(:title)
        end
end
