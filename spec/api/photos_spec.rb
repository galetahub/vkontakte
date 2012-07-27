# encoding: utf-8
require "spec_helper"

describe Vkontakte::Api::Photos do
  it "should be valid" do
    Vkontakte::Api::Photos.should be_a(Module)
  end

  context "params" do
    before(:each) do
      @token = '3a3d250e705051b03ed479343c3ec2833783eea3eea29860182716ed1d40319'
      @iframe = Vkontakte::App::Iframe.new
      @iframe.auth = {'access_token' => @token}
    end

    it "should be call getAlbums method" do
      response = '{"response":[{"aid":"17071606","thumb_id":"98054577","owner_id":"6492","title":"",
"description":"","created":"1204576880","updated":"1229532461", "size":"3","privacy":"0"}]}'

      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/photos.getAlbums?access_token=#{@token}",
        :body => response)

      @iframe.photos.getAlbums.should == [{"aid" => "17071606","thumb_id" => "98054577","owner_id" => "6492","title" => "", "description" => "","created" => "1204576880","updated" => "1229532461", "size" => "3","privacy" => "0"}]
    end

  end
end
