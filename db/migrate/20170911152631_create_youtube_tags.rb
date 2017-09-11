class CreateYoutubeTags < ActiveRecord::Migration[5.1]
  def change
    create_table :youtube_tags do |t|
      t.string :title

      t.timestamps
    end
    
    add_index :youtube_tags, :title, unique: true
  end
end
