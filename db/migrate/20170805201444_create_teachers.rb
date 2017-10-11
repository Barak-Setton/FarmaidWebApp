class CreateTeachers < ActiveRecord::Migration[5.1]
  def change
    create_table :teachers do |t|
      t.column :name, :string, :limit => 32, :null => false
      t.column :password, :string, :limit => 32, :null => false
      t.column :email, :string, :limit => 32, :null => false
      t.column :phone_number, :string, :limit => 32, :null => false
      t.column :image, :string, :limit => 128, :null => true
      t.column :institute_id, :int, :limit=>11, :null => false

      t.timestamps
    end
  end
end
