class ChangeDataHashColumnLengthInSitesModel < ActiveRecord::Migration
  def change
    change_column :sites, :data_hash, :string, :limit => 30
  end
end
