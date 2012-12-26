class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.string :name
      t.string :email
      t.boolean :confirmed

      t.timestamps
    end
    add_index :newsletters, :email, :unique => true
  end
end
