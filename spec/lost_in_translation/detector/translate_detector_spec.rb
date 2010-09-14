require File.dirname(__FILE__) + '/../../spec_helper'

include LostInTranslation
include LostInTranslation::Detector

describe TranslateDetector do
  before do
    @observer = mock('observer')
    @detector = TranslateDetector.new(@observer)
  end
  
  it "should notify t(key) method calls" do
    src = SourceCode.new "t('foo.bar')"
    @observer.should_receive(:notify).with('foo.bar')
    @detector.method_call(*src.syntax_tree[1..3])
  end

  it "should notify t(key) method calls with options" do
    src = SourceCode.new "t('foo.bar', :locale => :en)"
    @observer.should_receive(:notify).with('foo.bar')
    @detector.method_call(*src.syntax_tree[1..3])
  end

  it "should notify translate(key) method calls" do
    src = SourceCode.new "translate('foo.bar')"
    @observer.should_receive(:notify).with('foo.bar')
    @detector.method_call(*src.syntax_tree[1..3])
  end

  it "should notify t(key) method call with a receiver" do
    src = SourceCode.new "I18n.t('foo.bar')"
    @observer.should_receive(:notify).with('foo.bar')
    @detector.method_call(*src.syntax_tree[1..3])
  end

  it "should scope key with view path" do
    src_file = SourceFile.new fixture_path("views/partial_view.html.erb")
    detector = TranslateDetector.new(@observer, src_file)
    @observer.should_receive(:notify).with("partial_view.bar")
    detector.method_call(nil, :t, [:arglist, [:str, '.bar']])
  end

  it "should not notify a t method call with no arguments" do
    src = SourceCode.new "t()"
    @observer.should_not_receive(:notify)
    @detector.method_call(*src.syntax_tree[1..3])
  end

  it "should notify once for each key for a bulk translation" do
    src = SourceCode.new "t(['foo.bar', 'foo.baz'])"
    @observer.should_receive(:notify).once.with('foo.bar')
    @observer.should_receive(:notify).once.with('foo.baz')
    @detector.method_call(*src.syntax_tree[1..3])
  end
end
