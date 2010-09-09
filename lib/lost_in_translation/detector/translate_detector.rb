module LostInTranslation
  module Detector
    class TranslateDetector
      def initialize(observer)
        @observer = observer
      end
      
      def method_call(receiver, name, args)
        # If the method name is t or translate and it has first arg
        if [:translate, :t].include?(name)
          @observer.notify extract_translation_key(args)
        end
      end

      private
        def extract_translation_key(args)
          args[1][1] unless args[1].nil?
        end
    end
  end
end
