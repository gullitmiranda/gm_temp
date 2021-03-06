ActiveAdmin.register User do
  menu  priority: 1,
        parent: I18n.t('activerecord.models.settings'),
        if: proc{can?(:update, User)}
  #
  filter :firstname
  filter :lastname
  filter :email

  #TODO: Gab es hierfür eienn Grund?
  #actions :all, :except => [:new]

  form :html => { :enctype => "multipart/form-data" }  do |f|
    # f.actions
    f.inputs I18n.t("activerecord.attributes.user.general") do
      f.input :title
      f.input :firstname
      f.input :lastname
      f.input :email
      if current_user.has_role?('admin')
        f.input :roles, :as => :check_boxes, :collection => Role.all
      end
      f.input :password, hint: I18n.t("activerecord.attributes.user.password_hint")
      f.input :password_confirmation, hint: I18n.t("activerecord.attributes.user.password_confirmation")
      f.input :enable_expert_mode
      f.input :function
      f.input :phone
      f.input :fax
      f.input :facebook
      f.input :twitter
      f.input :linkedin
      f.input :googleplus
    end
    # f.inputs I18n.t("activerecord.attributes.user.history") do
    #   f.has_many :vita_steps do |step|
    #     if step.object.new_record?
    #       step.input :description, as: :string, label: I18n.t("activerecord.attributes.user.entry")
    #       step.input :title, label: "Bearbeiter", hint: "Tragen Sie hier Ihren Namen ein, damit die Aktion zugeordnet werden kann"
    #     else
    #       render :partial => "/admin/users/vita_steps", :locals => {:step => step}
    #     end
    #   end
    # end

    f.actions
  end


  index do
    selectable_column
    column :firstname
    column :lastname
    column :email
    column :roles do |u|
      u.roles.map{|r| r.name.capitalize}.join(", ")
    end
    default_actions
  end

  show :title => :title do |u|
    panel User.model_name.human do
      attributes_table_for user do
        [:firstname, :lastname, :title, :email, :gender, :function, :phone, :fax, :facebook, :twitter, :linkedin, :googleplus, :created_at, :updated_at].each do |aa|
          row aa
        end
      end
    end #end panel applicant
  end

  # batch_action :destroy, false

  controller do
    def update
      @user = User.find(params[:id])
      if params[:user] && params[:user][:password] && params[:user][:password_confirmation]
        unless params[:user][:password].length > 0 && params[:user][:password_confirmation].length > 0
          @user.update_without_password(params[:user])
        end
      end
      @user.update_attributes(params[:user])
      render action: :edit
    end
  end
end
