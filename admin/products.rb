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
    column :reference, :sortable => :reference do |p|
      best_in_place p, :reference, type: :input, path: [:admin, p]
    end
    column :name, :sortable => :name do |p|
      title = p.name if p.name.to_s.length < 40
      link_to(truncate(p.name, :length => 40), [:admin, p], title: "#{title || ""}" )
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
    column :tag_list, :sortable => :tag_list do |p|
      best_in_place p, :tag_list, type: :input, path: [:admin, p]
    end
    column :published, :sortable => :published do |p|
      best_in_place p, :published, type: :checkbox, path: [:admin, p]
    end
  end
  
  filter :name
  filter :id
  filter :reference
  
  show do
    render :partial => "admin/products/show", locals: { :s => product }
  end
  
  # Formulário de edição dos itens e suas traduções
  form :partial => "admin/products/form"

  controller do
    def update
      StandardiseNumbers.new(params[:product], %w{ price length width height weight })
      update!
      @product.reorder_positions params[:product]['upload_ids'] unless params[:product]['upload_ids'].blank?
    end
  end
end
