class CreateInstances < ActiveRecord::Migration
  def change
    create_table :instances do |t|
      t.references :app, index: true
      t.references :framework, index: true
      t.string :url
      t.timestamps
    end
  end
end
