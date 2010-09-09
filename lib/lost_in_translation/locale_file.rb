module LostInTranslation

  class LocaleFile
    include I18n::Backend::Flatten
    
    def initialize(filename, key_seperator = '.')
      @name = filename
      @key_seperator = key_seperator
      load_file(filename)
    end

    attr_reader :name

    def touch(key)
      key = normalize_key(key)
      translations.inject(false) do |a, (locale, data)|
        a ||= if data.has_key?(key)
          data[key] = true
        else
          false
        end
      end
    end

    def untouched_keys
      translations.inject([]) do |a, (locale, data)|
        a += data.keys.select { |k| !data[k] }.map { |k| k.to_s }
      end
    end
    
  protected

    def normalize_key(key)
      I18n::Backend::Flatten.normalize_flat_keys(nil, key, nil, nil).to_sym
    end
    
    def translations
      @translations ||= {}
    end
          
    def store_translations(locale, data)
      translations[locale] = flatten_translations(locale, data, true, false).inject({}) do |h, (k,v)|
        h.merge(k => false)
      end
    end
    
    def load_file(path)
      type = File.extname(path).tr('.', '').downcase
      data = case type
      when 'rb'
        eval(IO.read(path), binding, path)
      when 'yml'
        YAML::load(IO.read(path))
      else
        raise ArgumentError.new("file type #{type} is not supported")
      end
      raise InvalidLocaleFileError unless data.is_a?(Hash)
      data.each { |locale, d| store_translations(locale, d) }
    end
  end

  class InvalidLocaleFileError < StandardError; end
    
end
