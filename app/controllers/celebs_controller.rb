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

def profile
  begin
  @celeb = Celeb.first(conditions: {screenName: params[:name]})
    @tweets=@celeb.tweets.order_by([[:time,:desc]]).limit(15)
    @fantweets=FanTweet.where(:reply_to => @celeb.screenName).order_by([[:time,:desc]]).limit(15)
    @images=Photo.where(:reply_to => @celeb.screenName).order_by([[:time,:desc]]).limit(30)
@imageStr=Array.new
@images.each do |image|
urlstr=  url_for :controller =>"celebs", :action => "profile", :name => image.screenName
@imageStr <<  "<li><a target=\"_blank\" href=\"#{urlstr}\">#{image.name}</a><a target=\"_blank\" href=\"#{image.url}\"><img width=\"150\" height=\"150\" src=\"#{image.small}\"/></a><div class=\"divTime\"><span class=\"epoch\">#{image.time}</span></div></li>"
end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @celeb }
    end
  rescue
  redirect_to :root
end
end
  # GET /celebs/1
  # GET /celebs/1.json
  def show
    @celeb = Celeb.find(Integer(params[:id]))
    @tweets=@celeb.tweets.order_by([[:time,:desc]]).limit(15)
    @fantweets=FanTweet.where(:reply_to => @celeb.screenName).order_by([[:time,:desc]]).limit(15)
    respond_to do |format|
      format.html { render html: @celeb,:layout=>false}# show.html.erb
      format.json { render json: @celeb }
    end
  end
 def feed
   @celeb = Celeb.find(Integer(params[:id]))
    @tweets=@celeb.tweets.order_by([[:time,:desc]]).limit(15).where(:time.lt =>Integer(params[:time]) )
  
respond_to do |format|
format.html {   render :partial => "celebs/feed", :locals =>{ :tweets =>  @tweets ,:url=> feed_tweets_path(:time => @tweets.to_a.last.time) } }#_list.html.erb
format.json{render json: @tweets}
end
end
  def top
  @celebs=Celeb.sort(:followers).limit(params[:count])
respond_to do |format|
format.html { render html: @celebs,:layout=>false}#top.html.erb
format.json{render json: @celebs}
end
end
  # GET /celebs/new
  # GET /celebs/new.json
  def new
    @celeb = Celeb.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @celeb }
    end
  end

  # GET /celebs/1/edit
  def edit
    @celeb = Celeb.find(Integer(params[:id]))
  end

  # POST /celebs
  # POST /celebs.json
  def create
    @celeb = Celeb.new(params[:celeb])

    respond_to do |format|
      if @celeb.save
        format.html { redirect_to @celeb, notice: 'Celeb was successfully created.' }
        format.json { render json: @celeb, status: :created, location: @celeb }
      else
        format.html { render action: "new" }
        format.json { render json: @celeb.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /celebs/1
  # PUT /celebs/1.json
  def update
    @celeb = Celeb.find(params[:id])

    respond_to do |format|
      if @celeb.update_attributes(params[:celeb])
        format.html { redirect_to @celeb, notice: 'Celeb was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @celeb.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /celebs/1
  # DELETE /celebs/1.json
  def destroy
    @celeb = Celeb.find(params[:id])
    @celeb.destroy

    respond_to do |format|
      format.html { redirect_to celebs_url }
      format.json { head :ok }
    end
  end
end
