class HomeController < ApplicationController
  def index

 @alphaCelebs=Celeb.order_by([[:name]])
    @tweets=Tweet.order_by([[:time,:desc]]).limit(15)
        @fantweets=FanTweet.order_by([[:time,:desc]]).limit(5)
@followCelebs=Celeb.order_by([[:followers,:desc]]).limit(5)
@mentionCelebs=Celeb.order_by([[:followers,:desc]]).limit(5)
@talkCelebs=Celeb.order_by([[:followers,:desc]]).limit(5)
@tags=Celeb.alltags
@tmstamp=@tweets.to_a.last.time
@char="A"
respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @celebs }
      format.js
    end
    
    end

end
