require "spec_helper"

describe Vkontakte::Api::Profile do
  it "should be valid" do
    Vkontakte::Api::Profile.should be_a(Module)
  end

  context "params" do
    before(:each) do
      @token = '7a1cfdd37a3b72167a3b7216ac7a1347bde7a3b7a3a7216c95a735a210be6d4'
      @user = Vkontakte::App::User.new('2592709', :access_token => @token)
    end

    it "should be call users.get method" do
      response = '{"response":[{"uid":2592709, "last_name":"Галета", "first_name":"Павел"}]}'

      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/users.get?uids=2592709&access_token=#{@token}",
        :body => response)

      @user.fetch.should_not be_blank
    end

  end
end
