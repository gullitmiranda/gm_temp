ActiveAdmin.register Upload do
  menu  priority: 1,
        label: Upload.model_name.human.pluralize,
        parent: I18n.t('activerecord.models.content_management'),
        if: proc{can?(:read, Upload)}
  # 
  # menu false;

  controller.authorize_resource :class => Upload


  if ActiveRecord::Base.connection.table_exists?("tags")
    Upload.tag_counts_on(:tags).each do |utag|
      if(utag.count > 5)
        scope(I18n.t(utag.name, :scope => [:rdcms, :widget_types], :default => utag.name)){ |t| t.tagged_with(utag.name) }
      end
    end
  end

  form :html => { :enctype => "multipart/form-data" }  do |f|
    f.actions
    f.inputs "File" do
      f.input :upload, :as => :file
    end
    f.inputs "Allgemein" do
      f.input :source
      f.input :rights
      f.input :tag_list, :hint => "Tags sind komma-getrennte Werte, mit denen sich ein Artikel verschlagworten l&auml;sst", :label => "Liste von Tags"
      f.input :description, :input_html => { :class =>"tinymce", :rows => 3}
      f.input :alt_text
    end
  end

  index do
    # Seleção para ações em lote
    selectable_column
    # Columa ID com link para visualização do objeto
    id_column
    
    # column I18n.t("activerecord.attributes.upload.preview") do |i|
    column :preview do |i|
      link_to i.upload.url, :class => "image_thumb", :rel => "prettyPhoto", :target => "_blank" do
        image_tag i.upload.url(:mini)
      end
    end
    
    column :upload_file_name do |o|
      best_in_place o, :upload_file_name, type: :input, path: [:admin, o]
    end

    column :tag_list do |o|
      best_in_place o, :tag_list, type: :input, path: [:admin, o]
    end

    # column :upload_file_name, :upload_file_name
    column :upload_content_type, :upload_content_type
    column :upload_file_size, :sortable => :upload_file_size do |i|
      div :class => "align-right" do
        number_to_human_size i.upload_file_size
      end
    end

    column :updated_at
    # column :created_at

    column "" do |upload|
      if upload.upload_file_name && upload.upload_file_name.include?(".zip")
        link_to(raw("entpacken"), unzip_file_admin_upload_path(upload))
      end
    end
  end

  show do
    render :partial => "show", locals: { :s => upload }
  end
  
  sidebar :image_formates do
    ul do
      li "original  => WxH"
      li "large     => 900x900>"
      li "big       => 600x600>"
      li "medium    => 570x324#"
      li "thumb     => 260x180#"
      li "mini      => 50x50#"
    end
  end

  #batch_action :destroy, false
  controller do
    def index
      index! do |format|
        format.html # index.html.erb
        # format.json { render json: @uploads }
        format.json { render json: @uploads.map{|upload| upload.to_jq_upload } }
      end
    end

    def create
      create! do |format|
        if @upload.save
          format.html {
            render :json => [@upload.to_jq_upload].to_json,
            :content_type => 'text/html',
            :layout => false
          }
          format.json { render json: [@upload.to_jq_upload].to_json, status: :created }
          # format.json { render json: [@upload.to_jq_upload].to_json, status: :created, location: admin_upload_path(@upload) }
        else
          format.html { render action: "new" }
          format.json { render json: @upload.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  member_action :unzip_file do
    upload = Upload.find(params[:id])
    upload.unzip_files
    redirect_to :action => :index, :notice => "File unzipped"
  end

  action_item :only => [:edit, :show] do
    if resource.upload_file_name && resource.upload_file_name.include?(".zip")
      link_to('Zip-Datei entpacken', unzip_file_admin_upload_path(resource), :target => "_blank")
    end
  end
end
