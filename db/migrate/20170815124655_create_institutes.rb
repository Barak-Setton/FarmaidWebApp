class CreateInstitutes < ActiveRecord::Migration[5.1]
  def change
    create_table :institutes do |t|
      t.column :institute_name, :string, :limit => 32, :null => false
      t.column :teacher_admin_id, :int, :limit => 11, :null => true

      t.timestamps
    end
  end
end
