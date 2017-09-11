class UsersController < ApplicationController
    before_action :set_user, only: [:show]
    
    def show
        if(current_user == @user)
            youtube_api = YoutubeApi.new
            @account = youtube_api.get_account(@user)
            @subscribed_channels = @account.subscribed_channels
        end
    end
    
    private

        def set_user
            @user = User.find(params[:id]) || User.find(params[:user_id])
        end
end
