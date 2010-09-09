require 'optparse'

module LostInTranslation
  module Cli

    class Application
      def initialize(argv)
        @command = nil
        @argv = argv
        @locale_paths = ["./**/locales"]
        parse_options!(argv)
      end

      attr_reader :locale_paths, :source_paths

      def run!
        UnusedCommand.new(self.sources, self.translations).run!
      end

      def parse_options!(args)
        opts = OptionParser.new do |opts|
          opts.banner = "Usage: lit [options]"

          opts.separator " "
          opts.separator "Specific options:"

          opts.on("-l [path]", "--locales", "Path to locale .yml .rb files") do |t|
            @locale_paths = [t.gsub(/\/$/, '')]
          end
          
          opts.on_tail("--version", "Show version") do |v|
            puts LostInTranslation::VERSION
            exit
          end

          opts.on_tail("-h", "--help", "Show this message") do
            puts opts
            exit
          end
        end
        opts.parse!(args)
        @source_paths = args
      end

      def sources
        FileLocator.new(source_paths, ['rb', 'erb']).map { |path| SourceFile.new(path) }
      end

      def translations
        FileLocator.new(locale_paths, ['rb', 'yml']).map { |path| LocaleFile.new(path) }
      end  
    end
  end
end
