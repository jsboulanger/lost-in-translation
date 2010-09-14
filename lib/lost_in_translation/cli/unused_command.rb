module LostInTranslation
  module Cli
    class UnusedCommand
      def initialize(sources, translations)
        @sources, @translations = [sources, translations]
      end

      attr_reader :sources, :translations

      def run!
        parser = LostInTranslation::CodeParser.new
        puts "Searching source code:"

        self.sources.each do |source|
          parser.detectors[0] = LostInTranslation::Detector::TranslateDetector.new(self, source)
          print "."
          parser.process(source.syntax_tree)
        end

        puts "\n\nUnused translations:"

        self.translations.each do |translation|
          puts translation.name if translation.untouched_keys.size > 0
          translation.untouched_keys.sort.each do |key|
            puts "    #{key}"
          end
        end
      end      

      def notify(key)
        self.translations.each { |t| t.touch(key) }
      end
    end
  end
end
