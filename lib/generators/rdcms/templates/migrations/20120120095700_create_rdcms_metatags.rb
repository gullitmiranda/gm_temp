class CreateRdcmsMetatags < ActiveRecord::Migration
  def change
    create_table :rdcms_metatags do |t|
      t.string :name
      t.string :value
      t.integer :article_id

      t.timestamps
    end
  end
end
