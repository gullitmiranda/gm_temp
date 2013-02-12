class PostsCacheWorker
  include Sidekiq::Worker
  sidekiq_options queue: "default"

  def perform
    #cache leeren
    Post.active.each do |post|
      post.updated_at = Time.now
      post.save
    end
    #Alte Versionen von has_paper_trail löschen (https://github.com/airblade/paper_trail)
    if ActiveRecord::Base.connection.table_exists?("settings")
      if Setting.for_key("rdcms.remove_old_versions.active") == "true"
        weekcount = Setting.for_key("rdcms.remove_old_versions.weeks").to_i
        Version.delete_all ["created_at < ?", weekcount.weeks.ago]
      end
    end
  end

end
