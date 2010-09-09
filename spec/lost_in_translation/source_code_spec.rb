require File.dirname(__FILE__) + '/../spec_helper'

include LostInTranslation

describe SourceCode, "#syntax_tree" do
  it "returns an ast of a snippet of code" do
    src = SourceCode.new("translate('key')")
    src.syntax_tree.to_a.should == [:call, nil, :translate, [:arglist, [:str, "key"]]]
  end
end
