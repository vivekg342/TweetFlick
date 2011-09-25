class HomeController < ApplicationController
  def index

 #@alphaCelebs=Celeb.order_by([[:name]])
    @tweets=Tweet.order_by([[:time,:desc]]).only(:id,:time,:text,:celeb_id).limit(15)
        @fantweets=FanTweet.order_by([[:time,:desc]]).only(:id,:time,:text,:fan_id,:reply_to,:name,:screenName,:profileImgUrl).limit(30)
@followCelebs=Celeb.order_by([[:followers,:desc]]).only(:name,:screenName,:profileImgUrl,:followers).limit(5)
images=Photo.order_by([[:time,:desc]]).limit(30)
@imageStr=Array.new
images.each do |image|
urlstr=  url_for :controller =>"celebs", :action => "profile", :name => image.screenName
@imageStr <<  "<li style=\"overflow:hidden\"><a target=\"_blank\" href=\"#{urlstr}\"><span style=\"white-space:nowrap\">#{image.name}</span></a><a target=\"_blank\" href=\"#{image.url}\"><img width=\"84\" height=\"60\" src=\"#{image.small}\"/></a><div class=\"divTime\"><span class=\"epoch\">#{image.time}</span><span class=\"ltime\">#{image.time}</span></div></li>"
end
@mentionCelebs=Celeb.mostmentionedtoday
@talkCelebs=Celeb.mosttweetstoday
@weekstats=Celeb.weekstats
#@fanweekstats=FanTweet.weekstats
#@featured=Celeb.random
 @featured=Celeb.featured
#@tags=Celeb.alltags
@tmstamp=@tweets.to_a.last.time
@date = 0.days.ago.beginning_of_day.to_i * 1000

respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @celebs }
      format.js
    end
    
    end

def suggest
  begin
   auth = request.env["omniauth.auth"]
    unless !user_signed_in?
     # current_user.update_status(@tweet.text)
  #  @c = Celeb.first(conditions: {id: Integer(params[:id])}) || FanTweet.first(conditions: {fan_id: Integer(params[:id])})
debugger
suggest= Suggest.new

suggest.name = params[:cname]
suggest.userName = params[:cid]
suggest.email = params[:cemail]
suggest.comments = params[:comments]
suggest.save
result={:success =>  "true", :message => "Thank you."}
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

end
