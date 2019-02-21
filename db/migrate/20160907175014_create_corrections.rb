class CreateCorrections < ActiveRecord::Migration
  def change
    create_table :corrections do |t|
      t.string :avant
      t.string :demande
      t.text :description
      t.belongs_to :project
      t.belongs_to :user
      t.timestamps null: false
    end
    change_table :projects do |f|
      f.belongs_to :user
    end
  end
end
