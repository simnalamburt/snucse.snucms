class ChangeTypeOfDataHashColumnOfSitesTable < ActiveRecord::Migration
  def change
    change_column :sites, :data, :string
    change_column :sites, :data_hash, :string, :limit => 20

    change_column_default :sites, :data, 'eJxj4YhmAAAA4gBo'
    change_column_default :sites, :data_hash, 'BbnUIJYuEq1+BLsIS9AXXcaJ0SA='
  end
end
