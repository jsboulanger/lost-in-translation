$:.unshift File.expand_path(File.dirname(__FILE__))

module LostInTranslation
  VERSION = '0.0.1'
end

require 'rubygems'

gem 'i18n', '>= 0.4.1'

require 'i18n'
require 'erubis'
require 'ruby_parser'

begin
  # Only if we are working with Rails, the tool will still work if we don't.
  require 'action_view'
rescue LoadError
end

require 'lost_in_translation/cli/application'
require 'lost_in_translation/cli/unused_command'
require 'lost_in_translation/code_parser'
require 'lost_in_translation/detector/translate_detector'
require 'lost_in_translation/file_locator'
require 'lost_in_translation/source_code'
require 'lost_in_translation/source_file'
require 'lost_in_translation/locale_file'
