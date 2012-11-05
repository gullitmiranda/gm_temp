ActiveAdmin.register Product do
# ActiveAdmin.register Product do
  menu  priority: 2,
        # label: Product.model_name.human.pluralize,
        if: proc{can?(:update, Product)}
  # 
  controller.authorize_resource :class => Product

  # Listagem dos produtos
  index do
    selectable_column
    
    column :id
    column :name do |product|
      link_to product.name, [:admin, product]
    end
    column :price, :sortable => :price do |p|
      div :class => "align-right" do
        number_to_currency p.price
      end
    end
    column :weight, :sortable => :weight do |p|
      div :class => "align-right" do
        "#{p.weight || 0} kg" if p.weight
      end
    end
    column :measures do |p|
      div :class => "align-right" do
        "#{p.length || 0}x#{p.width || 0}x#{p.height || 0} m"
      end
    end
    column :tag_list do |p|
      best_in_place p, :tag_list, type: :input, path: [:admin, p]
    end

    # default_actions
  end
  
  filter :name
  filter :id
  
  show do
    render :partial => "admin/products/show", locals: { :s => product }
  end
  
  # Formulário de edição dos itens e suas traduções
  form :partial => "admin/products/form"
end
