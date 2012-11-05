class CreateVita < ActiveRecord::Migration
  def change
    create_table :vita do |t|
      t.references :loggable, :polymorphic => true
      t.integer :user_id
      t.string :title
      t.text :description

      t.timestamps
    end
    add_index :vita, :loggable_id
  end
end
