class RenameMetricSetColumn < ActiveRecord::Migration
  def change
    rename_column :metric_sets, :doc_elements, :dom_elements
  end
end
