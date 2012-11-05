class CreateHelps < ActiveRecord::Migration
  def change
    create_table :helps do |t|
      t.string :title
      t.text :description
      t.string :url

      t.timestamps
    end
    Help.create!(:title => "Rdcms", :description => "http://www.requestdev.com.br/administrative-tool")
    
  end
end
