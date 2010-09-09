require File.dirname(__FILE__) + '/../spec_helper'

include LostInTranslation

describe CodeParser do
  before do
    @detector = mock('detector')
    @parser = CodeParser.new(@detector)
  end
  
  it "should not fail with nil" do
    @parser.process(nil)
  end

  it "should notify detector of a method call" do
    src = SourceCode.new("I18n.t('foo.bar') if true")
    @detector.should_receive(:method_call).with([:const, :I18n], :t, [:arglist, [:str, "foo.bar"]])
    @parser.process(src.syntax_tree)
  end  
end
