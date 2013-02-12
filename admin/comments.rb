#encoding: utf-8

ActiveAdmin.register Comment, :as => 'comment' do
  menu  priority: 4,
        label: Comment.model_name.human.pluralize,
        parent: I18n.t("activerecord.models.blog.one"),
        if: proc{can?(:read, Comment)}
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
      f.input :article, :as => :select, :collection => Post.scoped
      # f.input :article, :as => :select, :collection => Article.scoped
      f.input :commentator, :as => :select, :collection => Setting.for_key("rdcms.comments.commentator").constantize.scoped
    end
    f.actions
  end

  index do
    selectable_column
    column :content
    column :active
    column :approved
    column :reported
    column :article do |comment|
      link_to 'Anzeigen', comment.article.public_url if comment.article.present?
    end
    column :created_at do |comment|
      comment.created_at.strftime('%d.%m.%Y %H:%M Uhr')
    end
    column "" do |comment|
      result = ""
      result += link_to(t(:edit), edit_admin_comment_path(comment.id), :class => "member_link edit_link edit", :title => "bearbeiten")
      result += link_to(t(:delete), admin_comment_path(comment.id), :method => :DELETE, :confirm => "Kommentar löschen?", :class => "member_link delete_link delete", :title => "loeschen")
      raw(result)
    end
  end
end
