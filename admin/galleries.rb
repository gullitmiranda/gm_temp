ActiveAdmin.register Gallery do
  menu  :priority => 3,
        if: proc{can?(:update, Gallery)}
  # menu false
  controller.authorize_resource :class => Gallery
  
  # Listagem dos itens
  index do
    selectable_column
    
    column :id
    column :name, :sortable => :name do |gallery|
      link_to gallery.name, [:admin, gallery]
    end
    column :datetime
    column :tag_list do |p|
      best_in_place p, :tag_list, type: :input, path: [:admin, p]
    end

    # default_actions
  end

  show do
    render :partial => "show", locals: { :s => gallery }
  end
  
  # Formulário de edição dos itens e suas traduções
  # form :partial => "admin/products/form"

  # Formulário de edição dos itens e suas traduções
  form :partial => "form"
end
