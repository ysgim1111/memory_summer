class CreateCelebrities < ActiveRecord::Migration
  def change
    create_table :celebrities do |t|
      t.integer :count
      t.string :cate
      t.string :ce_name
      t.string :site_name
      t.string :you_nickname
      t.timestamps null: false
    end
  end
  
  def ranking
   Celebrity.where('ce_name > ?', ce_name).count + 1
  end
end
