class User
  include Mongoid::Document

  field :provider,type: String
  field :uid,type: String
  field :name,type: String
  field :image,type: String
field :token,type: String
field :secret,type: String
def self.create_with_omniauth(auth)
    begin
      create! do |user|

        user.provider = auth['provider']
        user.uid = auth['uid']
        if auth['user_info']
          user.name  = auth['user_info']['name'] if auth['user_info']['name'] # Twitter, Google, Yahoo, GitHub
          user.image = auth['user_info']['image'] if auth['user_info']['image'] #Twitter
          user.email = auth['user_info']['email'] if auth['user_info']['email'] # Google, Yahoo, GitHub

        end
        if auth['extra']['user_hash']
          user.name = auth['extra']['user_hash']['name'] if auth['extra']['user_hash']['name'] # Facebook
          user.email = auth['extra']['user_hash']['email'] if auth['extra']['user_hash']['email'] # Facebook

        end
        if auth['credentials']
          user.token=  auth['credentials']['token'] if  auth['credentials']['token']
user.secret= auth['credentials']['secret'] if auth['credentials']['secret']
        end
      end
    rescue Exception
      raise Exception, "cannot create user record"
    end
  end

def update_status(msg)

    
     @message = msg
     #@t = Twitter::Client.new
  
     Twitter.configure do |config|
               config.oauth_token = token
       config.oauth_token_secret = secret
     end
   
client = Twitter::Client.new
     ret = client.update(@message)
     #tweet ||= Tweet.create_from_response(ret, auth.id)

    
end
def follow(id)

Twitter.configure do |config|
               config.oauth_token = token
       config.oauth_token_secret = secret
     end

client = Twitter::Client.new
ret = client.follow(id)
     #tweet ||= Tweet.create_from_response(ret, auth.id)


end
def retweet(id)
Twitter.configure do |config|
               config.oauth_token = token
       config.oauth_token_secret = secret
     end

client = Twitter::Client.new
ret = client.retweet(id)
     #tweet ||= Tweet.create_from_response(ret, auth.id)


end
def reply(msg,id)
 @message = msg
     #@t = Twitter::Client.new

     Twitter.configure do |config|
               config.oauth_token = token
       config.oauth_token_secret = secret
     end

client = Twitter::Client.new
     ret = client.update(@message,options= {:in_reply_to_status_id  => id})
end
end
