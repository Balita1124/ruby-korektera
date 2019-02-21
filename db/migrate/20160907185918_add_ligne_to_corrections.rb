class AddLigneToCorrections < ActiveRecord::Migration
  def change
    add_column :corrections, :ligne, :integer
    add_column :corrections, :page, :integer
    remove_column :corrections, :demande, :string
    add_column :corrections, :demande, :text
  end
end
