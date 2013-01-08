class CreatePartnersUploads < ActiveRecord::Migration
  def change
    create_table :partners_uploads do |t|
      t.references :partner, :upload
    end
  end
end
