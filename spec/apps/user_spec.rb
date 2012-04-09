require "spec_helper"

describe Vkontakte::App::User do
  it "should be valid" do
    Vkontakte::App::User.should be_a(Module)
  end

  context "fetch" do
    before(:each) do
      @user = Vkontakte::App::User.new('uid', :access_token => 'ACCESS_TOKEN')
    end

    it "should load user profile" do
      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/users.get?access_token=ACCESS_TOKEN&uids=uid",
        :body => '{"response":[{"uid":2592709, "last_name":"Галета", "first_name":"Павел"}]}')

      @user.fetch.should_not be_blank
    end
  end
end
