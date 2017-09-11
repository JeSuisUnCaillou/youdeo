class CreateYoutubeTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :title

      t.timestamps
    end
    
    add_index :tags, :title, unique: true
  end
end
