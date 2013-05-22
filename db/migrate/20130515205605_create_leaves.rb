class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.string :username
      t.string :name

      t.timestamps
    end
  end
end
