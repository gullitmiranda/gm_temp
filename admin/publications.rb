ActiveAdmin.register Publication do
  menu  priority: 7,
        parent: proc{ I18n.t('activerecord.models.content_management') },
        if: proc{can?(:update, Publication)}
  # menu false

  scope :publication_root, default: true

  index do
    selectable_column

    column :id
    column :name, :sortable => :name do |p|
      title = p.name if p.name.to_s.length < 40
      link_to(truncate(p.name, :length => 40), [:admin, p], title: "#{title || ""}" )
    end
    column :object_type, :sortable => :object_type do |p|
      best_in_place p, :object_type, type: :select, path: [:admin, p],
            :collection => [["0"  , I18n.t("attributes_all.catalogue" ) ], ["1"   , I18n.t("attributes_all.campaign"  ) ]]
    end
    column :tag_list, :sortable => :tag_list do |p|
      best_in_place p, :tag_list, type: :input, path: [:admin, p]
    end
    column :children do |p|
      p.children.count
    end

    column :datetime

    column :published, :sortable => :published do |p|
      best_in_place p, :published, type: :checkbox, path: [:admin, p]
    end
  end

  show do
    render :partial => "show", locals: { :@publication => publication }
  end

  form :partial => "form"

  controller do
    # layout nil, :except => [:edit]

    def index
      index! do |format|
        format.html # index.html.erb
        format.json { render json: @publications.map{|publication| publication.to_jq_upload } }
      end
    end

    def edit_page
      @publication = Publication.find(params[:id])
      render :layout => false, :template => 'admin/publications/edit_page'
    end

    def create
      create! do |format|
        if @publication.save
          format.html { redirect_to admin_publication_path @publication }
          format.json { render json: [@publication.to_jq_upload].to_json, status: :created }
        else
          format.html { render action: "new" }
          format.json { render json: @publication.errors, status: :unprocessable_entity }
        end
      end
    end
    def update
      unless params['ids_order'].blank?
        Publication.reorder_positions params['ids_order']
        respond_to do |format|
          format.json { render json: {
            success: true,
            message: I18n.t("notices.ordered.success")
            }.to_json }
        end
      else
        update! do |format|
          format.html do
            if request.xhr?
              render json: @publication.to_jq_upload
            else
              redirect_to @publication
            end
          end
        end
      end
    end
  end

  # batch_action :destroy, false
  config.clear_sidebar_sections!
end
