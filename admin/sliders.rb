ActiveAdmin.register Slider do
  menu  priority: 3,
        parent: I18n.t('activerecord.models.content_management'),
        if: proc{can?(:update, Slider)}
  # menu false

  config.sort_order = "position asc, updated_at desc"

  index :download_links => false do
    render :partial => "index"
  end

  show do
    render :partial => "show", locals: { :s => slider }
  end

  form :partial => "form"

  controller do
    def index
      index! do |format|
        format.html # index.html.erb
        format.json { render json: { files: @sliders.map{|slider| slider.to_jq_upload } } }
      end
    end

    def edit
      @slider = Slider.find(params[:id])
      render :layout => false, :template => 'admin/sliders/form'
    end

    def create
      unless params['reorder_positions'].blank?
        Slider.reorder_positions params['ids_order']

        respond_to do |format|
          format.json { render json: {
            success: true,
            message: I18n.t("notices.ordered.success")
            }.to_json }
        end
      else
        create! do |format|
          if @slider.save
            format.html { redirect_to admin_slider_path @slider }
            format.json { render json: { files: [@slider.to_jq_upload].to_json }, status: :created }
          else
            format.html { render action: "new" }
            format.json { render json: @slider.errors, status: :unprocessable_entity }
          end
        end
      end
    end

    def update
      update! do |format|
        format.html do
          if request.xhr?
            render json: { files: @slider.to_jq_upload }
          else
            redirect_to @slider
          end
        end
      end
    end
  end

  batch_action :destroy, false
  config.clear_sidebar_sections!
end
