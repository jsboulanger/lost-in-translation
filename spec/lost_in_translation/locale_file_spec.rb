require File.dirname(__FILE__) + '/../spec_helper'

include LostInTranslation

describe LocaleFile do
  before do
    @locale = LocaleFile.new(fixture_path('en.yml'))
  end

  describe "#initialize" do
    it "should load a translation hash from a ruby file" do
      @locale = LocaleFile.new(fixture_path('en.rb'))
      @locale.untouched_keys.should include("ruby_foo.bar")
    end
    
    it "should raise a InvalidLocaleFileError when the file is not a translation" do
      lambda { LocaleFile.new(fixture_path('model.rb')) }.should raise_error(InvalidLocaleFileError)
    end

    it "should raise ... when the file does not exist" do
      lambda { LocaleFile.new(File.join(File.dirname(__FILE__), 'does_not_exist.rb')) }.should raise_error(Errno::ENOENT)
    end    
  end
    
  describe "#touch" do
    it "returns true for an existing string key" do
      @locale.touch("foo.bar").should == true
    end

    it "return true for an existing array key" do
      @locale.touch([:foo, :bar]).should == true
    end

    it "returns false for a key that does not exist" do
      @locale.touch("foo.does_not_exist").should == false
    end
  end

  describe "#untouched_keys" do
    it "includes untouched keys" do
      @locale.untouched_keys.should include("foo.bar")
    end
 
    it "does not include a touched key" do
      @locale.touch("foo.bar")
      @locale.untouched_keys.should_not include("foo.bar")
    end
  end
end
