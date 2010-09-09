require 'rubygems'
require 'rspec'
# optionally add autorun support
require 'rspec/autorun'

require File.dirname(__FILE__) + '/../lib/lost_in_translation'
#require File.join(File.dirname(__FILE__), '..', 'lib', 'lost_in_translation')

Rspec.configure do |c|
  c.mock_with :rspec
end

def fixture_path(filename)
  File.join(File.dirname(__FILE__), 'fixtures', filename)
end
