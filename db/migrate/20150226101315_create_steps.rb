class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.integer :position, default: 1
      t.text :instruction

      t.timestamps null: false
    end
  end
end
