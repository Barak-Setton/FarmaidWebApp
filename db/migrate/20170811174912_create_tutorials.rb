class CreateTutorials < ActiveRecord::Migration[5.1]
  def change
    create_table :tutorials do |t|
      t.column :tutorial_type, :string, :limit => 32, :null => false
      t.column :crop_id, :int, :limit => 11, :null => false



      t.timestamps
    end
  end
end
