class CelebsController < ApplicationController
  # GET /celebs
  # GET /celebs.json
  def index
    @celebs = Celeb.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @celebs }
    end
  end

def link
  begin
       
  @celeb = Celeb.first(conditions: {screenName: params[:name]})
#          @alphaCelebs=Celeb.order_by([[:name]])
#   @tags=Celeb.alltags
    unless @celeb.nil?
      redirect_to profile_path(:name => @celeb.screenName)
    else
      redirect_to 'http://twitter.com/'+params[:name]
    end
rescue Exception => e
  redirect_to root_url
end
end
def profile
  begin
       
  @celeb = Celeb.first(conditions: {screenName: params[:name]})
#          @alphaCelebs=Celeb.order_by([[:name]])
#   @tags=Celeb.alltags
    @date = 0.days.ago.beginning_of_day.to_i * 1000
    @tweets=@celeb.tweets.order_by([[:time,:desc]]).only(:id,:time,:text,:celeb_id).limit(15)
    @fantweets=FanTweet.where(:reply_to => @celeb.screenName).order_by([[:time,:desc]]).only(:id,:time,:text,:fan_id,:name,:screenName,:reply_to,:profileImgUrl).limit(30) 
    images=Photo.where(:screenName => @celeb.screenName).order_by([[:time,:desc]]).limit(30)
    @imageStr=Array.new
  unless images.empty?
    images.each do |image|

    @imageStr <<  "<li><a target=\"_blank\" href=\"#{image.url}\"><img width=\"84\" height=\"60\" src=\"#{image.small}\"/></a><div class=\"divTime\"><span class=\"epoch\">#{image.time}</span><span class=\"ltime\">#{image.time}</span></div></li>"
    end
  end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @celeb }
    end
rescue Exception => e
  redirect_to root_url
end
end
  # GET /celebs/1
  # GET /celebs/1.json
  def show
    @celeb = Celeb.find(Integer(params[:id]))
redirect_to profile_path(:name => @celeb.screenName)
     end
 def feed
   @celeb = Celeb.find(Integer(params[:id]))
    @tweets=@celeb.tweets.order_by([[:time,:desc]]).limit(15).where(:time.lt =>Integer(params[:time]) ).only(:id,:time,:text,:celeb_id)
  
respond_to do |format|
format.html {   render :partial => "celebs/feed", :locals =>{ :tweets =>  @tweets ,:url=> feed_celebs_path(:time => @tweets.to_a.last.time) } }#_list.html.erb
format.json{render json: @tweets}
end
end
def list
  @tags=Celeb.alltags
  @alphaCelebs=Celeb.order_by([[:name]])
  respond_to do |format|
    format.html
    format.json {render json: @alphaCelebs}
  end
end  
def search
  query= Regexp.new(params[:name],true)
@celebs =Celeb.find(:all, :conditions => {:name => query }).only(:name,:screenName,:profileImgUrl).limit(15)
respond_to do |format|
  format.html
  format.json{render json: @celebs}
end
end

end
