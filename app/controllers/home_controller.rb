class HomeController < ApplicationController
  def index

 #@alphaCelebs=Celeb.order_by([[:name]])
    @tweets=Tweet.order_by([[:time,:desc]]).limit(15)
        @fantweets=FanTweet.order_by([[:time,:desc]]).limit(15)
@followCelebs=Celeb.order_by([[:followers,:desc]]).limit(5)
images=Photo.order_by([[:time,:desc]]).limit(30)
@imageStr=Array.new
images.each do |image|
urlstr=  url_for :controller =>"celebs", :action => "profile", :name => image.screenName
@imageStr <<  "<li><a target=\"_blank\" href=\"#{urlstr}\">#{image.name}</a><a target=\"_blank\" href=\"#{image.url}\"><img width=\"150\" height=\"150\" src=\"#{image.small}\"/></a><div class=\"divTime\"><span class=\"epoch\">#{image.time}</span><span class=\"ltime\">#{image.time}</span></div></li>"
end
@mentionCelebs=Celeb.mostmentionedtoday
@talkCelebs=Celeb.mosttweetstoday
@weekstats=Celeb.weekstats
#@fanweekstats=FanTweet.weekstats
@featured=Celeb.random
#@tags=Celeb.alltags
@tmstamp=@tweets.to_a.last.time
@date = 0.days.ago.beginning_of_day.to_i * 1000

respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @celebs }
      format.js
    end
    
    end

end
