class CreateRdcmsVita < ActiveRecord::Migration
  def change
    create_table :rdcms_vita do |t|
      t.references :loggable, :polymorphic => true
      t.integer :user_id
      t.string :title
      t.text :description

      t.timestamps
    end
    add_index :rdcms_vita, :loggable_id
  end
end
