ActiveAdmin.register Gallery do
  menu  :priority => 3,
        if: proc{can?(:update, Gallery)}
  # menu false
  controller.authorize_resource :class => Gallery

  # Listagem dos itens
  index do
    selectable_column

    column :id
    column :name, :sortable => :name do |p|
      title = p.name if p.name.to_s.length < 40
      link_to(truncate(p.name, :length => 40), [:admin, p], title: "#{title || ""}" )
    end
    column :datetime
    column :tag_list do |p|
      best_in_place p, :tag_list, type: :input, path: [:admin, p]
    end
    column :published, :sortable => :published do |p|
      best_in_place p, :published, type: :checkbox, path: [:admin, p]
    end
  end

  show do
    render :partial => "show", locals: { :@gallery => gallery }
  end

  # Formulário de edição dos itens e suas traduções
  form :partial => "form"

  controller do
    def update
      update!
      @gallery.reorder_positions params[:gallery]['upload_ids'] if params[:gallery].include?('upload_ids')
    end
  end
end
