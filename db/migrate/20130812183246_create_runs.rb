class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.references :instance, index: true
      t.references :test, index: true
      t.string :url
      t.string :url_json
      t.integer :run_number

      t.timestamps
    end
  end
end
