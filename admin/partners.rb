ActiveAdmin.register Partner do
  menu  priority: 8,
        parent: proc{ I18n.t('activerecord.models.content_management') },
        if: proc{can?(:update, Partner)}

  index do
    render "index", locals: { :@partners => partners }
  end

  form :partial => "form"

  controller do
    def index
      index! do |format|
        format.html # index.html.erb
        format.json { render json: @partners.map{|partner| partner.to_jq_upload } }
      end
    end

    def edit
      @partner = Partner.find(params[:id])
      render "edit", layout: false
    end

    def create
      create! do |format|
        if @partner.save
          format.html { redirect_to admin_partner_path @partner }
          format.json { render json: [@partner.to_jq_upload].to_json, status: :created }
        else
          format.html { render action: "new" }
          format.json { render json: @partner.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      unless params['ids_order'].blank?
        Partner.reorder_positions params['ids_order']
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
              render json: @partner.to_jq_upload
            else
              redirect_to @publication
            end
          end
        end
      end
    end
  end

  batch_action :destroy, false
  config.clear_sidebar_sections!
end