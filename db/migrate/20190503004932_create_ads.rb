class CreateAds < ActiveRecord::Migration[6.0]
  def change
    create_table :ads do |t|
      t.string :slug

      t.string :business_name
      t.string :headline
      t.text :body
      t.string :cta
      t.string :landingpage_url

      t.timestamps
    end

    add_index :ads, :slug, unique: true
  end
end
