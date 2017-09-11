class CreateYoutubeChannels < ActiveRecord::Migration[5.1]
  def change
    create_table :channels do |t|
      t.string :uid

      t.timestamps
    end
    
    add_index :channels, :uid, unique: true
  end
end
