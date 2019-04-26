class CreateTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :topics do |t|
      t.string :name
      t.string :slug
      t.string :quora_slug

      t.integer :followers_count, default: 0
      t.integer :questions_count, default: 0

      t.timestamps
    end

    add_index :topics, :slug, unique: true
  end
end
