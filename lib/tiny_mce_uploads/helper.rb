module TinyMceUploads
  module Helper
    
    def using_tiny_mce?
      not @tinymce_used_themes.blank?
    end

    def tiny_mce_uploads_javascripts
      (javascript_include_tag('tiny_mce_uploads') + "\n" +
      tiny_mce_editors).html_safe
    end


    def tiny_mce_uploads_stylesheets
      stylesheet_link_tag 'tiny_mce_uploads'
    end

    def tiny_mce_uploads_javascripts_if_needed
      return tiny_mce_uploads_javascripts if using_tiny_mce?
      ""
    end

    def tiny_mce_uploads_stylesheets_if_needed
      return tiny_mce_uploads_stylesheets if using_tiny_mce?
      ""
    end

    private

    def tiny_mce_editors
      javascript_tag do
        @tinymce_used_themes.map do |name|
          theme = TinyMceUploads.config.theme(name) 
          unless theme.nil?
            theme.merge!(language: I18n.locale.to_s)
            "tinyMCE.init(#{theme.to_json});"
          else
            ""
          end
        end.join("\n").html_safe
      end
    end

  end
end

