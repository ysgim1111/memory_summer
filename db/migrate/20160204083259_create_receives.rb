class CreateReceives < ActiveRecord::Migration
  def change
    create_table :receives do |t|
      t.integer :cele_id
      t.integer :user_id
      t.integer :point
      t.string :cate
      t.string :reason
      t.string :category
      t.string :location
      t.string :you_nickname
      t.text :content
      t.timestamps null: false
    end
  end
end
