class AddActionToCorrections < ActiveRecord::Migration
  def change
    add_column :corrections, :action, :integer
  end
end
