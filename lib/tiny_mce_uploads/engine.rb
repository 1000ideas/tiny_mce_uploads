module TinyMceUploads
  class Engine < ::Rails::Engine
    
    initializer "precompile", :group => :all do |app|
      app.config.assets.precompile += ['tiny_mce_uploads.css', 'tiny_mce_uploads.js',
        'tinymce/plugins/fupload/style.css', 'tinymce/plugins/fupload/functions.js']
    end

    initializer "helper" do |app|
      ActiveSupport.on_load(:action_view) do
        include Helper
      end
    end

    initializer "controller" do |app|
      ActiveSupport.on_load(:action_controller) do
        include Base
      end
    end

  end 
end
