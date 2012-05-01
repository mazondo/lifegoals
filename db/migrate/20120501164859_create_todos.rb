class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.boolean :complete
      t.integer :goal_id

      t.timestamps
    end
  end
end
