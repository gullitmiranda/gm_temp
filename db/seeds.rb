admin = Rdcms::Role.find_or_create_by_name("admin")
guest = Rdcms::Role.find_or_create_by_name("guest")
user = User.create!(:email => "admin@rdcms.de", :password => "YMdgDmhQwF83hw", :password_confirmation => "YMdgDmhQwF83hw")
user.confirm!
user.roles << admin
Rdcms::Article.create!(content: "Diese Seite existiert leider nicht.", url_name: "404", breadcrumb: "Seite nicht gefunden", title: "404")
Rdcms::Article.create!(content: "", url_name: "search-results", breadcrumb: "Suchergebnisse", title: "Suchergebnisse")

