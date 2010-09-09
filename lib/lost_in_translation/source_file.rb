module LostInTranslation
  class SourceFile < SourceCode

    def initialize(path)
      @path = path
      super(load_file(path))
    end

    attr_reader :path

  protected

    def load_file(path)
      type = File.extname(path).tr('.', '').downcase
      case type
      when 'rb'
        IO.readlines(path).join
      when 'erb', 'rhtml'
        Erubis::Eruby.new(IO.readlines(path).join).src
      else
        raise ArgumentError.new("file type #{type} is not supported")
      end
    end
  end
end
