Rails.application.config.to_prepare do
  if !File.exists?(File.join(::Rails.root,"app","controllers","extend_posts_controller.rb"))
    t = File.open(File.join(Rdcms::Engine.root,'lib/generators/rdcms/templates/extend_posts_controller.rb'), "r")
    f = File.open(File.join(::Rails.root, 'app/controllers/extend_posts_controller.rb'), "w+") {|f| f.write(t.read)}
  end
end
