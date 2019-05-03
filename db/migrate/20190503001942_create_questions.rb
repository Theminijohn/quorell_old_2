class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :slug
      t.string :quora_slug

      t.integer :followers_count, default: 0
      t.integer :answers_count, default: 0
      t.string :raw_timestamp

      t.timestamps
    end

    add_index :questions, :slug, unique: true
    add_index :questions, :quora_slug, unique: true
  end
end
