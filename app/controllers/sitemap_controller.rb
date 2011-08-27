class SitemapController < ApplicationController
  
  def index
    @celebs=Celeb.order_by([[:followers,:desc]]).limit(500)
  debugger
    respond_to do |format|
      format.xml
    end
  end
end
