class AddSubidToUser < ActiveRecord::Migration
  def change
    add_column :users, :subid, :string
  end
end
