require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record'

class TinyMceUploadsGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end

  class << self
    delegate :next_migration_number, :to => ActiveRecord::Generators::Base
  end

  def create_migration_file
    migration_template 'migration.rb', 'db/migrate/create_attachments.rb'
  end

  def copy_themes_file
    copy_file "../../../../config/tiny_mce_themes.yml", "config/tiny_mce_themes.yml" 
  end

  def add_routes
    route 'tinymce_upload'
  end
end

