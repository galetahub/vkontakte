require "spec_helper"

describe Vkontakte::Api::Secure do
  it "should be valid" do
    Vkontakte::Api::Secure.should be_a(Module)
  end

  context "secure" do
    before(:all) do
      @token = '3a3d250e705051b03ed479343c3ec2833783eea3eea29860182716ed1d40319'

      FakeWeb.register_uri(:get,
        "https://oauth.vk.com/access_token?grant_type=client_credentials&client_id=#{Vkontakte.config.app_id}&client_secret=#{Vkontakte.config.app_secret}",
        :body => '{"access_token":"#{@token}"}')

      @app = Vkontakte::App::Secure.new
      @options = @app.secure.default_options.merge(:access_token => @token, :v => '5.24')
    end

    it "should call sendNotification" do
      p = @options.merge(:uids => 81202312, :message => "test")

      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/secure.sendNotification?" + HTTParty::HashConversions.to_params(p),
        :body => '{"response":"81202312"}')

      @app.secure.sendNotification(p).should == "81202312"
    end

    it "should call getAppBalance" do
      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/secure.getAppBalance?" + HTTParty::HashConversions.to_params(@options),
        :body => '{"response":5000}')

      @app.secure.getAppBalance(@options).should == 5000
    end

    it "should call getBalance" do
      p = @options.merge(:uid => 81202312)

      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/secure.getBalance?" + HTTParty::HashConversions.to_params(p),
        :body => '{"response":350}')

      @app.secure.getBalance(p).should == 350
    end

    it "should call withdrawVotes" do
      p = @options.merge(:uid => 81202312, :votes => 2)

      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/secure.withdrawVotes?" + HTTParty::HashConversions.to_params(p),
        :body => '{"response":2}')

      @app.secure.withdrawVotes(p).should == 2
    end

    it "should call getTransactionsHistory" do
      p = @options.merge(:uid => 81202312, :type => 0, :limit => 2)

      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/secure.getTransactionsHistory?" + HTTParty::HashConversions.to_params(p),
        :body => '{"response":[{"id":"65968","uid_from":"34804733","uid_to":"33239732","votes":"1000","date":"1243421339"},{"id":"65956","uid_from":"35003049","uid_to":"33239732","votes":"300","date":"1243421213"}]}')

      @app.secure.getTransactionsHistory(p).should == [{"votes"=>"1000", "uid_to"=>"33239732", "date"=>"1243421339", "id"=>"65968", "uid_from"=>"34804733"}, {"votes"=>"300", "uid_to"=>"33239732", "date"=>"1243421213", "id"=>"65956", "uid_from"=>"35003049"}]
    end

    it "should call addRating" do
      p = @options.merge(:uid => 81202312, :rate => 200)

      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/secure.addRating?" + HTTParty::HashConversions.to_params(p),
        :body => '{"response":{"rating_added":200}}')

      @app.secure.addRating(p).should == {"rating_added" => 200}
    end

    it "should call setCounter" do
      p = @options.merge(:uid => 81202312, :counter => 4)

      FakeWeb.register_uri(:get,
        "https://api.vk.com/method/secure.setCounter?" + HTTParty::HashConversions.to_params(p),
        :body => '{"response":1}')

      @app.secure.setCounter(p).should == 1
    end
  end
end
