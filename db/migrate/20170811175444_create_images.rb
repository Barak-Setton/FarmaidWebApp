class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.column :name, :string, :limit => 256, :null => false
      t.column :image_order, :int, :limit => 32, :null => false
      t.column :description, :string, :limit => 3000, :null => false
      t.column :tutorial_id, :int, :limit => 32, :null => false


      t.timestamps
    end
  end
end
