class AddDynamicredirectToRdcmsarticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :dynamic_redirection, :string, :default => "false"
    add_column :rdcms_articles, :redirection_target_in_new_window, :boolean, :default => false
  end
end
