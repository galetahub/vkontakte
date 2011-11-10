require "spec_helper"

describe Vkontakte::Api::Secure do
  it "should be valid" do
    Vkontakte::Api::Secure.should be_a(Module)
  end
  
  context "iframe" do
    before(:each) do
      @token = '3a3d250e705051b03ed479343c3ec2833783eea3eea29860182716ed1d40319'
      @iframe = Vkontakte::App::Iframe.new
      @options = @iframe.secure.default_options.merge(:access_token => @token)
    end
    
    it "should call sendNotification" do
      p = @options.merge(:uids => 81202312, :message => "test")
      
      FakeWeb.register_uri(:get, 
        "https://api.vkontakte.ru/method/secure.sendNotification?" + HTTParty::HashConversions.to_params(p), 
        :body => '{"response":"81202312"}')
      
      @iframe.secure.sendNotification(p).should == {"response"=>"81202312"}
    end
    
    it "should call getAppBalance" do
      FakeWeb.register_uri(:get, 
        "https://api.vkontakte.ru/method/secure.getAppBalance?" + HTTParty::HashConversions.to_params(@options), 
        :body => '{"response":5000}')
      
      @iframe.secure.getAppBalance(@options).should == {"response"=>5000}
    end
    
    it "should call getBalance" do
      p = @options.merge(:uid => 81202312)
      
      FakeWeb.register_uri(:get, 
        "https://api.vkontakte.ru/method/secure.getBalance?" + HTTParty::HashConversions.to_params(p), 
        :body => '{"response":350}')
      
      @iframe.secure.getBalance(p).should == {"response"=>350}
    end
    
    it "should call withdrawVotes" do
      p = @options.merge(:uid => 81202312, :votes => 2)
      
      FakeWeb.register_uri(:get, 
        "https://api.vkontakte.ru/method/secure.withdrawVotes?" + HTTParty::HashConversions.to_params(p), 
        :body => '{"response":2}')
      
      @iframe.secure.withdrawVotes(p).should == {"response"=>2}
    end
    
    it "should call getTransactionsHistory" do
      p = @options.merge(:uid => 81202312, :type => 0, :limit => 2)
      
      FakeWeb.register_uri(:get, 
        "https://api.vkontakte.ru/method/secure.getTransactionsHistory?" + HTTParty::HashConversions.to_params(p), 
        :body => '{"response":[{"id":"65968","uid_from":"34804733","uid_to":"33239732","votes":"1000","date":"1243421339"},{"id":"65956","uid_from":"35003049","uid_to":"33239732","votes":"300","date":"1243421213"}]}')
      
      @iframe.secure.getTransactionsHistory(p).should == {"response"=>[{"votes"=>"1000", "uid_to"=>"33239732", "date"=>"1243421339", "id"=>"65968", "uid_from"=>"34804733"}, {"votes"=>"300", "uid_to"=>"33239732", "date"=>"1243421213", "id"=>"65956", "uid_from"=>"35003049"}]}
    end
    
    it "should call addRating" do
      p = @options.merge(:uid => 81202312, :rate => 200)
      
      FakeWeb.register_uri(:get, 
        "https://api.vkontakte.ru/method/secure.addRating?" + HTTParty::HashConversions.to_params(p), 
        :body => '{"response":{"rating_added":200}}')
      
      @iframe.secure.addRating(p).should == {"response" => {"rating_added" => 200}}
    end
    
    it "should call setCounter" do
      p = @options.merge(:uid => 81202312, :counter => 4)
      
      FakeWeb.register_uri(:get, 
        "https://api.vkontakte.ru/method/secure.setCounter?" + HTTParty::HashConversions.to_params(p), 
        :body => '{"response":1}')
      
      @iframe.secure.setCounter(p).should == {"response" => 1}
    end
  end
end
