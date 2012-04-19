require 'spec_helper'

describe Vkontakte::Api::Likes do
  it 'should be valid' do
    Vkontakte::Api::Likes.should be_a(Module)
  end

  context 'iframe' do
    before(:each) do
      @token = '3a3d250e705051b03ed479343c3ec2833783eea3eea29860182716ed1d40319'
      @iframe = Vkontakte::App::Iframe.new
      @iframe.auth = {'access_token' => @token}
    end

    it 'should return user, liked this page' do
      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/likes.getList?type=sitepage&page_url=http%3A%2F%2Fvk.com&owner_id=1&access_token=#{@token}",
        :body => '{"response":{"count":2,"users":[1,2]}}')

      @iframe.likes.getList(:type => 'sitepage', :page_url => 'http://vk.com', :owner_id => 1).should eq ({"count" => 2, "users" => [1, 2]})
    end
  end

end