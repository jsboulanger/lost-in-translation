module LostInTranslation
  module Detector
    class TranslateDetector
      def initialize(observer, source_file = nil)
        @observer = observer
        @source_file = source_file
      end
      
      def method_call(receiver, name, args)
        # If the method name is t or translate and it has first arg
        if [:translate, :t].include?(name)
          keys = extract_translation_keys(args)
          keys.each do |key|
            @observer.notify normalize_key(key)
          end
        end
      end

      private
        def extract_translation_keys(args)
          arg = args[1]
          return [] if arg.nil?
          case arg.first
          when :str
            [arg[1]]
          when :array
            arg[1..-1].map { |a| a[1] }
          else
            []
          end          
        end

        def normalize_key(key)
          if key.first == "." && @source_file && defined?(ActionView::Template)
            key = ActionView::Template.new(@source_file.path).path_without_format_and_extension.split('/views/').last.gsub(%r{/_?}, ".") + key.to_s
          end
          key
        end
        
    end
  end
end
