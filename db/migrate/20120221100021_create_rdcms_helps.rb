class CreateRdcmsHelps < ActiveRecord::Migration
  def change
    create_table :rdcms_helps do |t|
      t.string :title
      t.text :description
      t.string :url

      t.timestamps
    end
    Rdcms::Help.create!(:title => "Rdcms", :description => "http://www.requestdev.com.br/administrative-tool")
    
  end
end
