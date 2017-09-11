class CreateYoutubeChannels < ActiveRecord::Migration[5.1]
  def change
    create_table :youtube_channels do |t|
      t.string :uid

      t.timestamps
    end
    
    add_index :youtube_channels, :uid, unique: true
  end
end
