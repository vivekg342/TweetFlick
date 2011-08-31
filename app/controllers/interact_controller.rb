class InteractController < ApplicationController
  
def index
   @alphaCelebs=Celeb.order_by([[:name]])
@celebdiscs= CelebDiscussion.order_by([[:updated,:desc]]).limit(10)
 @tags=Celeb.alltags
end
end
