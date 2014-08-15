require 'spec_helper'

describe Vkontakte::Api::Wall do
  it 'should be valid' do
    Vkontakte::Api::Wall.should be_a(Module)
  end

  context 'user' do
    before(:each) do
      @token = '3a3d250e705051b03ed479343c3ec2833783eea3eea29860182716ed1d40319'
      @user = Vkontakte::App::User.new("2592709", :access_token => @token)
    end

    it 'should return user wall posts' do
      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/wall.get?owner_id=2592709&access_token=#{@token}",
        :body => '{"response":{"count":2,"items":[1,2]}}')

      @user.wall.get(:owner_id => 2592709).should eq ({"count" => 2, "items" => [1, 2]})
    end
  end

end