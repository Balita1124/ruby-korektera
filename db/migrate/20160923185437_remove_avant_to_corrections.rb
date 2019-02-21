class RemoveAvantToCorrections < ActiveRecord::Migration
  def change
    remove_column :corrections, :avant, :string
    add_column :corrections, :avant, :text
    add_column :corrections, :etat, :integer
    add_column :corrections, :user_correcteur_id, :integer
  end
end
