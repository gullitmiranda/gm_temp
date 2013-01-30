ActiveAdmin.register Page do
  menu  priority: 6,
        parent: proc{ I18n.t('activerecord.models.content_management') },
        if: proc{can?(:update, Page)}
  # menu false

  controller.authorize_resource :class => Page

  # Listagem dos itens
  index do
    selectable_column

    column :id
    column :name, :sortable => :name do |p|
      title = p.name if p.name.to_s.length < 40
      link_to(truncate(p.name, :length => 40), [:admin, p], title: "#{title || ""}" )
    end
    column :updated_at
    column :in_menu, :sortable => :in_menu do |p|
      best_in_place p, :in_menu, type: :checkbox, path: [:admin, p]
    end
    column :published, :sortable => :published do |p|
      best_in_place p, :published, type: :checkbox, path: [:admin, p]
    end
  end

  show do
    render :partial => "show", locals: { :s => page }
  end

  # Formulário de edição dos itens e suas traduções
  form :partial => "form"

  filter :name
  filter :content
  filter :created_at
  filter :updated_at
end
