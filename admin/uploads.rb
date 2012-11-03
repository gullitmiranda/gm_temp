ActiveAdmin.register Rdcms::Upload, :as => "Upload"  do
  menu  priority: 1,
        label: proc{ I18n.t "activerecord.models.#{Rdcms::Upload.model_name.human.downcase}.other" },
        parent: I18n.t('activerecord.models.content_management'),
        if: proc{can?(:read, Rdcms::Upload)}
  # 
  menu false;

  controller.authorize_resource :class => Rdcms::Upload


  if ActiveRecord::Base.connection.table_exists?("tags")
    Rdcms::Upload.tag_counts_on(:tags).each do |utag|
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
    selectable_column
    column "url" do |upload|
      result = ""
      result << upload.upload.url
    end
    column :source, sortable: :source do |upload|
    	truncate(upload.source, length: 20)
    end
    column t("preview") do |upload|
      image_tag(upload.upload(:mini))
    end
    column :created_at, sortable: :created_at do |upload|
    	l(upload.created_at, format: :short)
    end
	  column "" do |upload|
	    if upload.upload_file_name && upload.upload_file_name.include?(".zip")
	      link_to(raw("entpacken"), unzip_file_admin_upload_path(upload))
	    end
	  end
    column "" do |upload|
      result = ""
      result += link_to(t(:view), admin_upload_path(upload), :class => "member_link edit_link view", :title => "Vorschau")
      result += link_to(t(:edit), edit_admin_upload_path(upload), :class => "member_link edit_link edit", :title => "bearbeiten")
      result += link_to(t(:delete), admin_upload_path(upload), :method => :DELETE, :confirm => t("delete_article", :scope => [:rdcms, :flash_notice]), :class => "member_link delete_link delete", :title => "loeschen")
      raw(result)
    end
  end

  show do
    attributes_table do
      row "Vorschau" do
          image_tag(upload.upload(:thumb))
      end
      row "original" do
        upload.upload(:original)
      end
      row "large" do
        upload.upload(:large)
      end
      row "big" do
        upload.upload(:big)
      end
      row "medium" do
        upload.upload(:medium)
      end
      row "thumb" do
        upload.upload(:thumb)
      end
      row "mini" do
        upload.upload(:mini)
      end
      row :source
      row :rights
      row :description
      row :tag_list
      row :upload_file_name
      row :upload_content_type
      row :upload_file_size
      row :created_at
      row :updated_at
    end
  end

  sidebar :image_formates do
    ul do
      li "original => AxB>"
      li "large => 900x900>"
      li "big => 600x600>"
      li "medium => 300x300>"
      li "thumb => 100x100>"
      li "mini => 50x50>"
    end
  end

  #batch_action :destroy, false
  controller do
    def index
      # @uploads = Rdcms::Upload
      #   .where(params[:accept_content_type] ? "upload_content_type REGEXP '#{params[:accept_content_type]}'" : "")
      #   .order(params[:order])
      #   .limit(params[:limit])
      #   .offset(params[:offset])
      
      index! do |format|
        format.html # index.html.erb
        # format.json { render json: @uploads }
        format.json { render json: @uploads.map{|upload| upload.to_jq_upload } }
      end
    end

  #   def create
  #     create! do |format|
  #       if @upload.save
  #         format.html {
  #           render :json => [@upload.to_jq_upload].to_json,
  #           :content_type => 'text/html',
  #           :layout => false
  #         }
  #         format.json { render json: [@upload.to_jq_upload].to_json, status: :created }
  #         # format.json { render json: [@upload.to_jq_upload].to_json, status: :created, location: admin_upload_path(@upload) }
  #       else
  #         format.html { render action: "new" }
  #         format.json { render json: @upload.errors, status: :unprocessable_entity }
  #       end
  #     end
  #   end
  end

  member_action :unzip_file do
    upload = Rdcms::Upload.find(params[:id])
    upload.unzip_files
    redirect_to :action => :index, :notice => "File unzipped"
  end

  action_item :only => [:edit, :show] do
    _upload = @_assigns['upload']
    if _upload.upload_file_name && _upload.upload_file_name.include?(".zip")
      link_to('Zip-Datei entpacken', unzip_file_admin_upload_path(_upload), :target => "_blank")
    end
   end
end
