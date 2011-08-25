class HomeController < ApplicationController
  def index

 @alphaCelebs=Celeb.order_by([[:name]])
    @tweets=Tweet.order_by([[:time,:desc]]).limit(15)
        @fantweets=FanTweet.order_by([[:time,:desc]]).limit(15)
@followCelebs=Celeb.order_by([[:followers,:desc]]).limit(5)
@images=Photo.order_by([[:time,:desc]]).limit(30)
@mentionCelebs=Celeb.mostmentionedtoday
@talkCelebs=Celeb.mosttweetstoday
@tags=Celeb.alltags
@tmstamp=@tweets.to_a.last.time
respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @celebs }
      format.js
    end
    
    end

end
