class CreateMetricSets < ActiveRecord::Migration
  def change
    create_table :metric_sets do |t|
      t.string :ms_type
      t.integer :load_time
      t.integer :ttfb
      t.integer :start_render
      t.integer :fully_loaded
      t.integer :speed_index
      t.integer :doc_elements
      t.references :run, index: true

      t.timestamps
    end
  end
end
