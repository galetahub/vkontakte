require "spec_helper"

describe Vkontakte::App::Iframe do
  it "should be valid" do
    Vkontakte::App::Iframe.should be_a(Module)
  end
  
  context "params" do
    before(:each) do
      @params = {"referrer"=>"profile", "is_app_user"=>"0", "api_settings"=>"0", "parent_language"=>"0", "hash"=>"", "sid"=>"db5aa091133cb1971817421f3cf14a1b78605ad2ab67218e8066c2bd57e736", "language"=>"0", "group_id"=>"0", "user_id"=>"2592709", "viewer_type"=>"1", "secret"=>"492aeb00af", "lc_name"=>"5941f805", "access_token"=>"3a3d250e705051b03ed479343c3ec2833783eea3eea29860182716ed1d40319", "viewer_id"=>"81202312", "api_url"=>"http://api.vkontakte.ru/api.php"}
      @params["auth_key"] = Vkontakte::Utils.md5([Vkontakte.config.app_id, @params['viewer_id'], Vkontakte.config.app_secret].join('_'))
      @params["api_result"] = '{"response":[{"uid":81202312,"first_name":"Tester","last_name":"Tester"}]}'
      @params["app_id"] = Vkontakte.config.app_id
      
      @iframe = Vkontakte::App::Iframe.new
      @iframe.params = @params
    end
    
    it "should parse request params" do
      @iframe.language.should == :ru
      @iframe.auth.should_not be_nil
      @iframe.auth['access_token'].should == @params["access_token"]
      @iframe.valid_auth_key?.should be_true
      # @iframe.api_result.should == {"response"=>[{"uid"=>81202312, "last_name"=>"Tester", "first_name"=>"Tester"}]}
    end
    
    it "should not be valid auth_key" do
      @iframe.params = @params.merge("auth_key" => 'wrong')
      @iframe.valid_auth_key?.should_not be_true
    end
  end
end
