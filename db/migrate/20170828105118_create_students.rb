class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.column :name, :string, :limit => 32, :null => false
      t.column :password, :string, :limit => 32, :null => false
      t.column :email, :string, :limit => 32, :null => false
      t.column :phone_number, :string, :limit => 32, :null => false
      t.column :profile_picture, :string, :limit => 128, :null => false
      t.column :institute_id, :int, :limit => 11, :null => false
      t.column :last_file_update, :datetime, :null => true
      t.column :last_message_update, :datetime, :null => true


      t.timestamps
    end
  end
end
