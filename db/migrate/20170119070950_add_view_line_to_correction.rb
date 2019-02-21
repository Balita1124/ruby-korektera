class AddViewLineToCorrection < ActiveRecord::Migration
  def change
    add_column :corrections, :view_line, :string
  end
end
