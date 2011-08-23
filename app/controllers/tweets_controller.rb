class TweetsController < ApplicationController

 def feed
#  @tweets=Tweet.paginate({:order => :time.desc,:per_page => 15 , :page => Integer(params[:page])})
 @tweets=Tweet.order_by([[:time,:desc]]).limit(15).where(:time.lt =>Integer(params[:time]) )
respond_to do |format|
format.html {   render :partial => "celebs/feed", :locals =>{ :tweets =>  @tweets ,:url=> feed_tweets_path(:time => @tweets.to_a.last.time) } }#_list.html.erb
format.json{render json: @tweets}
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
  result={:success =>  "false",:message => "Failed !"}
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
   result=j.encode({:success =>  "false" , :message => "Retweet failed "} )
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
   result={:success =>  "false", :message => "Reply failed "}
 end
respond_to do |format|
format.html { redirect_to root_url }#_list.html.erb
format.js {render :json => result}
end
end
end
