class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|

      t.timestamps null: false
    end
  end
end
