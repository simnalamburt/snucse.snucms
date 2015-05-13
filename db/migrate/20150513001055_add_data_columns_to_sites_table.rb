class AddDataColumnsToSitesTable < ActiveRecord::Migration
  def change
    add_column :sites, :data, :binary
    add_column :sites, :data_hash, :integer
  end
end
