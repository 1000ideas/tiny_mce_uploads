module TinyMceUploads
  require 'tinymce-rails'
  require 'tiny_mce_uploads/engine'
  require 'tiny_mce_uploads/version'
  require 'tiny_mce_uploads/routes_helper'
  require 'tiny_mce_uploads/configuration'
  require 'tiny_mce_uploads/base'
  require 'tiny_mce_uploads/helper'
  
  mattr_accessor :attachments_controller_superclass_name
  self.attachments_controller_superclass_name = "ApplicationController"

  mattr_accessor :only_allow_images
  self.only_allow_images = true
  
  def self.config
    @tinymce_themes ||= Configuration.load(::Rails.root.join("config/tiny_mce_themes.yml"))
  end
end
