ActiveAdmin.register Goldencobra::Article, :as => "Article" do
    
  form do |f|
    f.inputs "Allgemein" do
      f.input :title, :hint => "Der Titel der Seite, kann Leerzeichen und Sonderzeichen enthalten"
      f.input :url_name, :hint => "Nicht mehr als 64 Zeichen, sollte keine Umlaute, Sonderzeichen oder Leerzeichen enthalten."
      f.input :parent_id, :as => :select, :collection => Goldencobra::Article.all.map{|c| [c.title, c.id]}, :include_blank => true
    end
    f.inputs "Metadescription" do
      f.has_many :metatags do |m|
        m.input :name, :as => :select, :collection => Goldencobra::Article::MetatagNames, :input_html => { :class => 'metatag_names'} 
        m.input :value, :input_html => { :class => 'metatag_values'} 
        m.input :_destroy, :as => :boolean 
      end
    end
    f.inputs "Inhalt" do
      f.input :teaser
      f.input :content, :hint => "Dies ist ein Textfeld"
    end
    f.buttons
  end
  
  index do 
    column "title", :title do |article|
      content_tag("span", article.title, :class => article.startpage ? "startpage" : "")
    end
    column "url" do |article|
      link_to article.public_url, article.public_url, :target => "_blank"
    end
    column :created_at
    column :updated_at
    column "" do |article|
      result = ""
      result += link_to("New Subarticle", new_admin_article_path(:parent => article), :class => "member_link edit_link")
      result += link_to("View", admin_article_path(article), :class => "member_link view_link")
      result += link_to("Edit", edit_admin_article_path(article), :class => "member_link edit_link")
      result += link_to("Delete", admin_article_path(article), :method => :DELETE, :confirm => "Realy want to delete this Article?", :class => "member_link delete_link")
      raw(result)
    end
  end
  
  sidebar :startpage_options, :only => [:show, :edit] do 
      _article = @_assigns['article']
      if _article.startpage
        "This Article is the Startpage!"
      else
        link_to "Make this article Startpage", mark_as_startpage_admin_article_path(_article.id), :confirm => "Realy want to make this article as ROOT of your website"
      end
  end
  
  member_action :mark_as_startpage do
    article = Goldencobra::Article.find(params[:id])
    article.mark_as_startpage!
    redirect_to :action => :show, :notice => "This Article is the Startpage!"
  end
  
  controller do 
    def new 
      @article = Goldencobra::Article.new
      if params[:parent] && params[:parent].present? 
        @parent = Goldencobra::Article.find(params[:parent])
        @article.parent_id = @parent.id
      end
    end 
  end
  
    
end