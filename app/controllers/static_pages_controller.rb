class StaticPagesController < ApplicationController
    def home
        @tags = Tag.all_with_channels_count
    end
end
