class CreateMetatags < ActiveRecord::Migration
  def change
    create_table :metatags do |t|
      t.string :name
      t.string :value
      t.integer :article_id

      t.timestamps
    end
  end
end
