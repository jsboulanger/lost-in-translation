require File.dirname(__FILE__) + '/../../spec_helper'

include LostInTranslation::Cli
include LostInTranslation

describe Application do
  it "should set empty source paths by defaults" do
    Application.new([]).source_paths.should == []
  end

  it "should set locale paths to **/locales by default" do
    Application.new([]).locale_paths.should == ["./**/locales"]
  end

  it "should set source paths from the command line arguments" do
    paths = ["app/", "lib/"]
    Application.new(paths).source_paths.should == paths
  end

  it "should set the locale path from the --locales option" do
    path = "config/my_locales"
    Application.new(["--locales", path]).locale_paths.should == [path]
  end
end
