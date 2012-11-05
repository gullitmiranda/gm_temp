ActiveAdmin.register Comment, :as => 'comment' do
  menu  priority: 4,
        label: Comment.model_name.human.pluralize,
        parent: I18n.t("activerecord.models.blog.one"),
        if: proc{can?(:update, Comment)}
  # 
  menu false;

  form :html => { :enctype => "multipart/form-data" }  do |f|
    f.actions
    f.inputs do
      f.input :content
      f.input :active
      f.input :approved
      f.input :reported
      f.input :parent, :as => :select, :collection => Comment.scoped
      f.input :article, :as => :select, :collection => Article.scoped
      f.input :commentator, :as => :select, :collection => Setting.for_key("rdcms.comments.commentator").constantize.scoped
    end
    f.actions
  end

end