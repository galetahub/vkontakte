require "spec_helper"

describe Vkontakte::Api::Friends do
  it "should be valid" do
    Vkontakte::Api::Friends.should be_a(Module)
  end

  context "iframe" do
    before(:each) do
      @token = '3a3d250e705051b03ed479343c3ec2833783eea3eea29860182716ed1d40319'
      @iframe = Vkontakte::App::Iframe.new
      @iframe.auth = {'access_token' => @token}
    end

    it "should get friends list by uid param" do
      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/friends.get?access_token=#{@token}&uid=81202312",
        :body => '{"response":[2592709,3859793,4663468]}')

      @iframe.friends.get(:uid => 81202312).should == {"response"=>[2592709, 3859793, 4663468]}
    end

    it "should get friends list by fields" do
      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/friends.get?access_token=#{@token}&fields=81202312",
        :body => '{"response":[{"uid":2592709,"first_name":"Павел","last_name":"Галета","online":0},{"uid":3859793,"first_name":"Мария","last_name":"Семёнова","online":0},{"uid":4663468,"first_name":"Ekaterina","last_name":"Koronotova","online":0}]}')

      @iframe.friends.get(:fields => 81202312).should == {"response"=>[{"uid"=>2592709, "last_name"=>"\320\223\320\260\320\273\320\265\321\202\320\260", "online"=>0, "first_name"=>"\320\237\320\260\320\262\320\265\320\273"}, {"uid"=>3859793, "last_name"=>"\320\241\320\265\320\274\321\221\320\275\320\276\320\262\320\260", "online"=>0, "first_name"=>"\320\234\320\260\321\200\320\270\321\217"}, {"uid"=>4663468, "last_name"=>"Koronotova", "online"=>0, "first_name"=>"Ekaterina"}]}
    end

    it "should get getAppUsers" do
      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/friends.getAppUsers?access_token=#{@token}",
        :body => '{"response":[2592709]}')

      @iframe.friends.getAppUsers.should == {"response" => [2592709]}
    end

    it "should get getOnline" do
      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/friends.getOnline?access_token=#{@token}&uid=2592709",
        :body => '{"response":[2450999,2488708,2649518,4440077]}')

      @iframe.friends.getOnline(:uid => 2592709).should == {"response"=>[2450999, 2488708, 2649518, 4440077]}
    end

    it "should get getMutual" do
      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/friends.getMutual?target_uid=2450999&access_token=#{@token}&source_uid=2592709",
        :body => '{"response":[2301578,2619312,5818827,6391852,6411298,6422462]}')

      response = @iframe.friends.getMutual(:target_uid => 2450999, :source_uid => 2592709)
      response.should == {"response" => [2301578,2619312,5818827,6391852,6411298,6422462]}
    end
  end
end
