class UsersController < ApplicationController
    before_action :set_user, only: [:show]
    
    def show
        init_time = DateTime.now
        
        if(current_user == @user)
            @tags, @uncategorized_channels = @user.tags_and_channels_hashs
        end
        
        
        @elapsed_time = ((DateTime.now - init_time) * 24 * 60 * 60).to_i
    end
    
    private

        def set_user
            @user = User.find(params[:id]) || User.find(params[:user_id])
        end
        
end
