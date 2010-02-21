require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Tablegrok" do
  it "should return a good parse of the table" do
    expected = eval(File.read(File.dirname(__FILE__) + "/expected.rb"))
    html = File.open(File.dirname(__FILE__) + "/sample.html")
    Tablegrok.new.parse(html).should == expected
  end
end
