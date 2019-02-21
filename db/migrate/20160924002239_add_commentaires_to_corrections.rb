class AddCommentairesToCorrections < ActiveRecord::Migration
  def change
    add_column :corrections, :commentaires, :text
  end
end
