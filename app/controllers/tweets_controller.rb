class TweetsController < ApplicationController

def archive
      @date=Integer(params[:time])
          nextdate=@date+86400000
            @id=params[:id]
   unless params[:name].nil?
       @celeb = Celeb.first(conditions: {screenName: params[:name]})
     @tweets=@celeb.tweets.order_by([[:time,:desc]]).where(:time => { "$lt" => nextdate, "$gte" => @date }).only(:id,:time,:text,:celeb_id)
  else
  @tweets=Tweet.order_by([[:time,:desc]]).where(:time => { "$lt" => nextdate, "$gte" => @date }).only(:id,:time,:text,:celeb_id)
end
end

 def feed
#  @tweets=Tweet.paginate({:order => :time.desc,:per_page => 15 , :page => Integer(params[:page])})
 @tweets=Tweet.order_by([[:time,:desc]]).limit(15).where(:time.lt =>Integer(params[:time]) ).only(:id,:time,:text,:celeb_id)
respond_to do |format|
format.html {   render :partial => "celebs/feed", :locals =>{ :tweets =>  @tweets ,:url=> feed_tweets_path(:time => @tweets.to_a.last.time) } }#_list.html.erb
format.json{render json: @tweets}
end
end

def fanfeed
  
 @tweets=FanTweet.order_by([[:time,:desc]]).limit(15).where(:time.gt =>Integer(params[:time]) )

respond_to do |format|
format.html {   render :partial => "tweets/fanfeed", :locals =>{ :tweets =>  @tweets ,:url=> fanfeed_tweets_path(:time => @tweets.to_a.first.time) } }#_list.html.erb
format.json{render json: @tweets}
end
end
def latest
   unless params[:id].nil?
     celeb = Celeb.find(Integer(params[:id]))
     @tweets=celeb.tweets.order_by([[:time,:desc]]).where(:time.gt =>Integer(params[:time])).only(:id,:time,:text,:celeb_id).limit(15)
    @fantweets=FanTweet.order_by([[:time,:desc]]).where(:reply_to => celeb.screenName,:time.gt =>Integer(params[:time])).only(:id,:time,:text,:fan_id,:name,:screenName,:profileImgUrl).limit(15)
  else
  @tweets=Tweet.order_by([[:time,:desc]]).where(:time.gt =>Integer(params[:time])).only(:id,:time,:text,:celeb_id).limit(15)
  @fantweets=FanTweet.order_by([[:time,:desc]]).where(:time.gt =>Integer(params[:time])).only(:id,:time,:text,:fan_id,:name,:screenName,:profileImgUrl).limit(15)
end
  unless @tweets.nil? || @tweets.empty?
  celebs= render_to_string :partial => "celebs/feed", :locals =>{ :tweets =>  @tweets,:url => nil }
end
unless @fantweets.nil?
  fans=render_to_string :partial => "tweets/fanfeed", :locals =>{ :tweets =>  @fantweets }
end
  
  respond_to do |format|
format.json{render json: {:celebs => celebs,:fans => fans,:time => Time.now.to_i * 1000 }}
end
end
def follow
  begin
   auth = request.env["omniauth.auth"]
    unless !user_signed_in?
     # current_user.update_status(@tweet.text)
    @c = Celeb.first(conditions: {id: Integer(params[:id])}) || FanTweet.first(conditions: {fan_id: Integer(params[:id])})

      current_user.follow(Integer(params[:id]))
result={:success =>  "true", :message => "Following #{@c.name}!"}
 else
  result={:success =>  "login",:message => "Login needed !"}
 end
rescue
  result={:success =>  "false",:message => "Failed !"}
end
respond_to do |format|
format.html { redirect_to root_url }#_list.html.erb
format.js {render :json => result}
end

end

 def retweet
 
   auth = request.env["omniauth.auth"]
   j = ActiveSupport::JSON
    unless !user_signed_in?
     # current_user.update_status(@tweet.text)
      current_user.retweet(Integer(params[:id]))
      result=j.encode({:success =>  "true" , :message => "Retweeted!"} )
 else
  result={:success =>  "login",:message => "Login needed !"}
 end
    respond_to do |format|
format.html { redirect_to root_url }
format.js {render :json => result}
end
end
def reply
   auth = request.env["omniauth.auth"]
    unless !user_signed_in?
      current_user.reply(params[:tweet],Integer(params[:id]))
result={:success =>  "true", :message => "Replied!"}
 else
  result={:success =>  "login",:message => "Login needed !"}
 end
respond_to do |format|
format.html { redirect_to root_url }#_list.html.erb
format.js {render :json => result}
end
end
end
