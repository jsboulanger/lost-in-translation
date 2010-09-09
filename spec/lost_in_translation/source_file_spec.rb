require File.dirname(__FILE__) + '/../spec_helper'

include LostInTranslation

describe SourceFile do
  it "should load the syntax tree of a ruby file" do
    source = SourceFile.new(fixture_path("model.rb"))
    source.syntax_tree.should be_instance_of(Sexp)
  end

  it "should load the syntax tree of an erb file" do
    source = SourceFile.new(fixture_path("view.html.erb"))
    source.syntax_tree.should be_instance_of(Sexp)
  end
end
