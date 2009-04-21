require File.dirname(__FILE__) + "/spec_helper"

describe SimpleLanguageParser do
  before do
    @parser = SimpleLanguageParser.new()
  end
  
  it "should be able to parse the sample code" do
    @parser.parse(SAMPLE_CODE).class.should == ProgramNode
  end
end
