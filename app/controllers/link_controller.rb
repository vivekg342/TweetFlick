
def link
  begin
       
  @celeb = Celeb.first(conditions: {screenName: params[:name]})
#          @alphaCelebs=Celeb.order_by([[:name]])
#   @tags=Celeb.alltags
    unless @celeb.nil?
      redirect_to profile_path(:name => @celeb.screenName)
    else
      redirect_to 'http://twitter.com/#{params[:name]}'
    end
rescue Exception => e
  redirect_to root_url
end
end
