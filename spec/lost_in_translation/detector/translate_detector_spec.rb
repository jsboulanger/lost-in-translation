require File.dirname(__FILE__) + '/../../spec_helper'

include LostInTranslation
include LostInTranslation::Detector

describe TranslateDetector do
  before do
    @observer = mock('observer')
    @detector = TranslateDetector.new(@observer)
  end
  
  it "should detect t(key) method calls" do
    src = SourceCode.new "t('foo.bar')"
    @observer.should_receive(:notify).with('foo.bar')
    @detector.method_call(*src.syntax_tree[1..3])
  end

  it "should detect t(key) method calls with options" do
    src = SourceCode.new "t('foo.bar', :locale => :en)"
    @observer.should_receive(:notify).with('foo.bar')
    @detector.method_call(*src.syntax_tree[1..3])
  end

  it "should detect translate(key) method calls" do
    src = SourceCode.new "translate('foo.bar')"
    @observer.should_receive(:notify).with('foo.bar')
    @detector.method_call(*src.syntax_tree[1..3])
  end

  it "should detect t(key) method call with a receiver" do
    src = SourceCode.new "I18n.t('foo.bar')"
    @observer.should_receive(:notify).with('foo.bar')
    @detector.method_call(*src.syntax_tree[1..3])
  end
end
