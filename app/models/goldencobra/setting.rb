module Goldencobra
  class Setting < ActiveRecord::Base
    has_ancestry :orphan_strategy => :restrict
    
    before_save :parse_title
    
    
    def self.for_key(name) 
      setting_title = name.split(".").last
      settings = Setting.where(:title => setting_title)
      if settings.count == 1
        return settings.first.value
      elsif settings.count > 1
        settings.each do |set|
          if [set.ancestors.map(&:title).join("."),setting_title].compact.join('.') == name
            return set.value
          end
        end
      else
        return ""
      end
    end
    
    
    def self.import_default_settings(path_file_name)
      if ActiveRecord::Base.connection.table_exists?("goldencobra_settings")
        require 'yaml'
        raise "Settings File '#{path_file_name}' does not exist" if !File.exists?(path_file_name)
        imports = open(path_file_name) {|f| YAML.load(f) }
        imports.each_key do |key|
          generate_default_setting(key, imports)
        end  
      end    
    end
    
    
    private
    def self.generate_default_setting(key, yml_data, parent_id=nil)
      if yml_data[key].class == Hash
        parent = Setting.find_by_ancestry_and_title(parent_id, key)
        unless parent
          parent = Setting.create(:ancestry => parent_id, :title => key)
        end
        yml_data[key].each_key do |name|
          generate_default_setting(name, yml_data[key], [parent.ancestry,parent.id].compact.join('/'))
        end
      elsif yml_data[key].class == String
        set = Setting.find_by_title_and_ancestry(key, parent_id)
        unless set
          Setting.create(:title => key , :value => yml_data[key], :ancestry => parent_id)
        end
      else
        raise "invalid yml File at: #{key}  -  #{yml_data}"
      end
    end
    
    
    def parse_title
      self.title = self.title.downcase
      self.title = self.title.gsub(".", "_")
    end
    
  end
end