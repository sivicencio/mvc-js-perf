class CreateTestSettings < ActiveRecord::Migration
  def change
    create_table :test_settings do |t|
      t.string :name
      t.string :value
      t.references :test, index: true

      t.timestamps
    end
  end
end
