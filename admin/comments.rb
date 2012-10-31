ActiveAdmin.register Rdcms::Comment, :as => "comment" do
  menu  priority: 4,
  label: proc{ I18n.t "activerecord.models.#{Rdcms::Comment.model_name.human.downcase}.other" },
        parent: I18n.t("activerecord.models.#{Rdcms::Article.model_name.human.downcase}.other"),
        if: proc{can?(:update, Rdcms::Comment)}
  # 

  form :html => { :enctype => "multipart/form-data" }  do |f|
    f.actions
    f.inputs do
      f.input :content
      f.input :active
      f.input :approved
      f.input :reported
      f.input :parent, :as => :select, :collection => Rdcms::Comment.scoped
      f.input :article, :as => :select, :collection => Rdcms::Article.scoped
      f.input :commentator, :as => :select, :collection => Rdcms::Setting.for_key("rdcms.comments.commentator").constantize.scoped
    end
    f.actions
  end

end