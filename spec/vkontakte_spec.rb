# encoding: utf-8
require 'spec_helper'

describe Vkontakte do
  it "should be valid" do
    Vkontakte.should be_a(Module)
  end
  
  context "setup" do
    before(:each) do
      Vkontakte.setup do |config|
        config.app_id = 1234567
        config.app_secret = "supersecretkey"
        config.format = :xml
        config.debug = false
        config.logger = nil
      end
    end
    
    it "should set config options" do
      Vkontakte.config.app_id.should == 1234567
      Vkontakte.config.app_secret.should == 'supersecretkey'
      Vkontakte.config.format.should == :xml
    end
    
    it "should raise error on not exists option" do
      lambda {
        Vkontakte.config.some_param
      }.should raise_error(StandardError)
    end
  end
end
