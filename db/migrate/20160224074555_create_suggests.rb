class CreateSuggests < ActiveRecord::Migration
  def change
    create_table :suggests do |t|
      t.integer :user_id
      t.string :category
      t.string :you_nickname
      t.string :you_email
      t.string :title
      t.string :content
      t.timestamps null: false
    end
  end
end
