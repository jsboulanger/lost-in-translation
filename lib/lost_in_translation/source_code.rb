module LostInTranslation
  class SourceCode

    @@err_io = $stderr

    class << self
      def err_io=(io)
        original = @@err_io
        @@err_io = io
        original
      end
    end

    def initialize(code, parser = RubyParser.new)
      @source = code
      @parser = parser
    end

    def syntax_tree
      begin
        ast = @parser.parse(@source)
      rescue Exception => error
        @@err_io.puts "#{error.class.name}: #{error}"
      end

      ast
    end
  end
end
