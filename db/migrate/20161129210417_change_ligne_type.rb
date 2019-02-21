class ChangeLigneType < ActiveRecord::Migration
  def change
    remove_column :corrections, :action
    add_column :corrections, :action, :string
  end
end
