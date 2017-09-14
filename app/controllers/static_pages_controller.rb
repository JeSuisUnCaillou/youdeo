class StaticPagesController < ApplicationController
    def home
        @tags = Tag.all_with_channels_hash
    end
end
