admin = Role.find_or_create_by_name("admin")
guest = Role.find_or_create_by_name("guest")
user = User.create!(:email => "admin@rd.dev", :password => "YMdgDmhQwF83hw", :password_confirmation => "YMdgDmhQwF83hw", :firstname => "Administrador", :lastname => "Requestdev")
user.confirm!
user.roles << admin

Help.create!(:title => "Requestdev Sistemas", :description => "http://www.requestdev.com.br")

# Post.create!(content: "Diese Seite existiert leider nicht.", url_name: "404", breadcrumb: "Seite nicht gefunden", title: "404")
# Post.create!(content: "", url_name: "search-results", breadcrumb: "Suchergebnisse", title: "Suchergebnisse")

Permission.create(:sorter_id => 1, :role_id => Role.find_by_name("admin").id, :action => "manage", :subject_class => ":all" )
Permission.create(:sorter_id => 1, :role_id => Role.find_by_name("guest").id, :action => "read", :subject_class => "Article" )
Permission.create(:sorter_id => 1, :role_id => Role.find_by_name("guest").id, :action => "show", :subject_class => "User", :subject_id => "user.id" )
Permission.create(:sorter_id => 1, :role_id => Role.find_by_name("guest").id, :action => "update", :subject_class => "User", :subject_id => "user.id" )
Permission.create(:sorter_id => 1, :role_id => Role.find_by_name("guest").id, :action => "destroy", :subject_class => "User", :subject_id => "user.id" )
