module TinyMceUploads
  module Base

    module ClassMethods
      def uses_tinymce(theme, options = {})
        self.before_filter(options) do |controller|
          controller.instance_variable_set(:@tinymce_used_themes, [*theme])
        end
      end
    end

    def self.included(base)
      base.extend ClassMethods 
    end
    
  end
end

