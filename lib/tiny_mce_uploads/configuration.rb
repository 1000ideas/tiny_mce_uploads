module TinyMceUploads
  class Configuration
    
    def initialize(options)
      @options = options
    end

    def self.defaults
      { mceinit_simple: { 
         mode: 'specific_textareas',
         editor_selector: 'editor',
         theme: 'simple' 
       }
      }
    end

    def load(filename)
      @options.merge!(YAML::load(ERB.new(IO.read(filename)).result))
    end

    def self.load(filename)
      c = new defaults
      c.load(filename)
      c
    end

    def theme(name)
      @options["mceinit_#{name.to_s}"]
    end

  end
end
