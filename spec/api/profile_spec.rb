# encoding: utf-8
require "spec_helper"

describe Vkontakte::Api::Profile do
  it "should be valid" do
    Vkontakte::Api::Profile.should be_a(Module)
  end

  context "params" do
    before(:each) do
      @token = '7a1cfdd37a3b72167a3b7216ac7a1347bde7a3b7a3a7216c95a735a210be6d4'
      @user = Vkontakte::App::User.new('2592709', :access_token => @token)

      response = '{"response":[{"uid":2592709, "last_name":"Галета", "first_name":"Павел"}]}'
      @friends_response = '{"response": {"count": 8, "items": [233297, 424407, 593420, 705017, 830116, 838081, 1075165, 1312768]}}'

      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/users.get?v=5.24&uids=2592709&access_token=#{@token}",
        :body => response)

      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/users.getFollowers?v=5.24&user_id=2592709&access_token=#{@token}",
        :body => @friends_response)

      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/friends.get?v=5.24&user_id=2592709&access_token=#{@token}",
        :body => @friends_response)
    end

    it "should be call users.get method" do
      @user.fetch.should_not be_blank
    end

    it "should have info in parsed_reponse" do
      @user.fetch.should eq [{"uid" => 2592709, "last_name" => "Галета", "first_name" => "Павел"}]
    end

    it "should be call friends method" do
      @user.fetch_friends["items"].size.should == 8
    end

    it "should be call followers method" do
      @user.fetch_followers["items"].size.should == 8
    end

    it "should not be call followers method without token" do
      @user = Vkontakte::App::User.new('2592709', :access_token => nil)
      lambda { @user.fetch_followers }.should raise_error
    end  

    it "should be call followers method without token with this config param" do
      Vkontakte.config.without_token = true
      @user = Vkontakte::App::User.new('2592709', :access_token => nil)

      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/users.getFollowers?v=5.24&user_id=2592709",
        :body => @friends_response)

      @user.fetch_followers["items"].size.should == 8
    end    

  end
end
