ActiveAdmin.register Post do
  menu  :priority => 3,
        if: proc{can?(:update, Post)}
  # menu false

  controller.authorize_resource :class => Post

  scope "All", :scoped, :default => true
  scope "Online", :active
  scope "Offline", :inactive

  # Listagem dos itens
  index do
    selectable_column

    column :id
    column :name, :sortable => :name do |p|
      title = p.name if p.name.to_s.length < 40
      link_to(truncate(p.name, :length => 40), edit_admin_post_path(p), title: "#{title || ""}" )
    end
    column :summary, :sortable => :summary do |p|
      text = strip_tags(p.summary).to_s.strip
      content_tag(:span, truncate(text, :length => 40), title: text )
    end
    column :datetime
    column :tag_list, :sortable => :tag_list do |p|
      best_in_place p, :tag_list, type: :input, path: [:admin, p]
    end
    column :published, :sortable => :published do |p|
      best_in_place p, :published, type: :checkbox, path: [:admin, p]
    end
  end
  # index do
  #   render :partial => "index", locals: { :posts => posts }
  # end
  # show do
  #   render :partial => "show", locals: { :s => post }
  # end
  # Formulário de edição dos itens e suas traduções
  form :partial => "form"

  filter :name
  filter :body
  filter :datetime
  filter :created_at
  filter :updated_at
end
