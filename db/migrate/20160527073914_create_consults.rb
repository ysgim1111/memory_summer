class CreateConsults < ActiveRecord::Migration
  def change
    create_table :consults do |t|

      t.timestamps null: false
    end
  end
end
