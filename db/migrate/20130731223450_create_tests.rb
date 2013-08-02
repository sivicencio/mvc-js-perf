class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :name
      t.text :description
      t.integer :total_runs
      t.text :script
      t.references :app, index: true

      t.timestamps
    end
  end
end
