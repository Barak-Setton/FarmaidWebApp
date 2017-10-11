class CreateMessages < ActiveRecord::Migration[5.1]
  def up
    create_table :messages do |t|

      t.column :message, :string, :limit => 5000, :null => false
      t.column :student_id, :int, :limit => 11, :null => false
      t.column :teacher_id, :int, :limit => 11, :null => false
      t.column :responded, :boolean, :default => false

      t.timestamps
    end
  end
end
