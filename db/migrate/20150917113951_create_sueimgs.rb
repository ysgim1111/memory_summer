class CreateSueimgs < ActiveRecord::Migration
  def change
    create_table :sueimgs do |t|
      t.integer :sueform_id
      t.string :sueimg
      t.timestamps null: false
    end
  end
end
