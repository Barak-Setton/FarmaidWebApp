class CreateResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :responses do |t|

      t.column :response, :string, :limit => 5000, :null => false
      t.column :teacher_id, :int, :limit => 11, :null => false
      t.column :student_id, :int, :limit => 11, :null => false

      t.timestamps
    end
  end
end
