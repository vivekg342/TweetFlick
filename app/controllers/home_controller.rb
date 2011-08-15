class HomeController < ApplicationController
  def index
#    @tweets=Tweet.paginate(:per_page => 15 , :page => 1)
@tweets=Tweet.order_by([[:time,:desc]]).limit(15)
@reply=Tweet.new
@topCelebs=Celeb.order_by([[:followers,:desc]]).limit(5)
@tmstamp=@tweets.to_a.last.time
@char="A"
respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @celebs }
      format.js
    end
    
    end

end
