module Rdcms
  class UploadsController < Rdcms::ApplicationController
    load_and_authorize_resource

    respond_to :js
    # GET /uploads
    # GET /uploads.json
    def index
      @uploads = Rdcms::Upload
        .where(params[:accept_content_type] ? "upload_content_type REGEXP '#{params[:accept_content_type]}'" : "")
        .order(params[:order])
        .limit(params[:limit])
        .offset(params[:offset])
      
      respond_to do |format|
        format.html # index.html.erb
        # format.json { render json: @uploads }
        format.json { render json: @uploads.map{|upload| upload.to_jq_upload } }
      end
    end
    
    # GET /uploads/1
    # GET /uploads/1.json
    # def show
    #   @upload =  Rdcms::Upload.find(params[:id])
    # 
    #   respond_to do |format|
    #     format.html # show.html.erb
    #     format.json { render json: @upload }
    #   end
    # end

    # GET /uploads/new
    # GET /uploads/new.json
    # def new
    #   @upload =  Rdcms::Upload.new
    # 
    #   respond_to do |format|
    #     format.html # new.html.erb
    #     format.json { render json: @upload }
    #   end
    # end

    # GET /uploads/1/edit
    # def edit
    #   @upload =  Rdcms::Upload.find(params[:id])
    # end

    # POST /uploads
    # POST /uploads.json
    def create
      @upload =  Rdcms::Upload.new(params[:upload])

      respond_to do |format|
        if @upload.save
          format.html {
            render :json => [@upload.to_jq_upload].to_json,
            :content_type => 'text/html',
            :layout => false
          }
          format.json { render json: [@upload.to_jq_upload].to_json, status: :created, location: @upload }
        else
          format.html { render action: "new" }
          format.json { render json: @upload.errors, status: :unprocessable_entity }
        end
      end
    end

    # PUT /uploads/1
    # PUT /uploads/1.json
    def update
      @upload =  Rdcms::Upload.find(params[:id])

      respond_to do |format|
        if @upload.update_attributes(params[:upload])
          format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @upload.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /uploads/1
    # DELETE /uploads/1.json
    def destroy
      @upload =  Rdcms::Upload.find(params[:id])
      @upload.destroy

      respond_to do |format|
        format.html { redirect_to uploads_url }
        format.json { head :no_content }
      end
    end
  end
end