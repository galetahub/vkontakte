# encoding: utf-8
require "spec_helper"

describe Vkontakte::Api::Groups do
  it "should be valid" do
    Vkontakte::Api::Groups.should be_a(Module)
  end

  context "iframe" do
    before(:each) do
      @token = '3a3d250e705051b03ed479343c3ec2833783eea3eea29860182716ed1d40319'
      @iframe = Vkontakte::App::Iframe.new
      @iframe.auth = {'access_token' => @token}
    end

    it "should get groups list by uid param" do
      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/groups.get?access_token=#{@token}&uid=81202312",
        :body => '{"response":[16527885]}')

      @iframe.groups.get(:uid => 81202312).should == [16527885]
    end

    it "should raise permission error on access friend groups" do
      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/groups.get?access_token=#{@token}&uid=2592709",
        :body => '{"error":{"error_code":7,"error_msg":"Permission to perform this action is denied by user","request_params":[{"key":"oauth","value":"1"},{"key":"method","value":"groups.get"},{"key":"uid","value":"2592709"},{"key":"access_token","value":"74aee6063ec4aea07047ba3cb47079607f870797079ea90fef75c6361570a5f"}]}}')

      lambda {
        @iframe.groups.get(:uid => 2592709)
      }.should raise_error Vkontakte::App::VkException
    end

    context "exists group" do
      before(:each) do
        @group_id = 16527885
      end

      it "should return group info" do
        FakeWeb.register_uri(:get,
          "https://api.vk.com/method/groups.getById?access_token=#{@token}&gid=#{@group_id}",
          :body => '{"response":[{"gid":16527885,"name":"Club Music Group of Kiev","screen_name":"club16527885","is_closed":0,"type":"group","photo":"http:\/\/cs884.vkontakte.ru\/g16527885\/c_08b73308.jpg","photo_medium":"http:\/\/cs884.vkontakte.ru\/g16527885\/b_6e68053d.jpg","photo_big":"http:\/\/cs884.vkontakte.ru\/g16527885\/a_ba67625c.jpg"}]}')

        @iframe.groups.getById(:gid => @group_id).should == [{"photo"=>"http://cs884.vkontakte.ru/g16527885/c_08b73308.jpg", "name"=>"Club Music Group of Kiev", "gid"=>16527885, "is_closed"=>0, "photo_medium"=>"http://cs884.vkontakte.ru/g16527885/b_6e68053d.jpg", "type"=>"group", "photo_big"=>"http://cs884.vkontakte.ru/g16527885/a_ba67625c.jpg", "screen_name"=>"club16527885"}]
      end

      it "should return group member" do
        FakeWeb.register_uri(:get,
          "https://api.vk.com/method/groups.isMember?access_token=#{@token}&gid=#{@group_id}&uid=81202312",
          :body => '{"response":1}')

        @iframe.groups.isMember(:uid => 81202312, :gid => @group_id).should == 1
      end

      it "should return all groups members" do
        FakeWeb.register_uri(:get,
          "https://api.vk.com/method/groups.getMembers?access_token=#{@token}&gid=#{@group_id}&count=5",
          :body => '{"response":{"count":29364,"users":[107765962,66506999,145557591,72256631,28639402]}}')

        response = @iframe.groups.getMembers(:gid => @group_id, :count => 5)
        response.should == {"count"=>29364, "users"=>[107765962, 66506999, 145557591, 72256631, 28639402]}
      end
    end

    describe '#join' do
      it 'should join to group' do
        FakeWeb.register_uri(:get,
          "https://api.vk.com/method/groups.join?access_token=#{@token}&gid=1", :body => '{"response":1}')

        response = @iframe.groups.join(:gid => 1)
        response.should == 1
      end
    end

    describe '#leave' do
      it 'should allow user to leave group' do
        FakeWeb.register_uri(:get,
          "https://api.vk.com/method/groups.leave?access_token=#{@token}&gid=1", :body => '{"response":1}')

        response = @iframe.groups.leave(:gid => 1)
        response.should == 1
      end
    end
  end
end
