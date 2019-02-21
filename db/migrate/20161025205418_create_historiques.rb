class CreateHistoriques < ActiveRecord::Migration
  def change
    create_table :historiques do |t|
      t.belongs_to :user
      t.string :action
      t.integer :project
      t.integer :correction

      t.timestamps null: false
    end
  end
end
