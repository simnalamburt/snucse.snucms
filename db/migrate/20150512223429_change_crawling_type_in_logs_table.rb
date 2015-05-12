class ChangeCrawlingTypeInLogsTable < ActiveRecord::Migration
  def change
    change_column :sites, :crawling_type, :integer
  end
end
