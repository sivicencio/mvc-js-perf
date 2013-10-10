class AddWptIdToRuns < ActiveRecord::Migration
  def change
    add_column :runs, :wpt_id, :string
  end
end
