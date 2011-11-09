require 'digest/md5'

module Vkontakte
  module Utils
    extend self
    
    def generate_cookie_sign(data, app_secret)
      md5(collect_params(data) + app_secret)
    end

    def generate_api_sign(cookies, data)
      cookies['secret'] ||= Vkontakte.config.app_secret
      md5(cookies['mid'], collect_params(data), cookies['secret'])
    end
    
    def collect_params(data)
      data.sort{|a, b| a.first.to_s <=> b.first.to_s}.collect{|key, value| "#{key}=#{value}"}.join
    end
    
    def md5(*args)
      Digest::MD5.hexdigest(args.join)
    end
  end
end
