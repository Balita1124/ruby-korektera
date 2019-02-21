class AddAction < ActiveRecord::Migration
  def change
    remove_column :corrections, :action
    add_column :corrections, :action, :integer
    remove_column :corrections, :ligne
    add_column :corrections, :ligne, :string
  end
end
