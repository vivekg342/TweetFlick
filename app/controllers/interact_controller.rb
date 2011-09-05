class InteractController < ApplicationController
  
def index
@celebdiscs= CelebDiscussion.order_by([[:updated,:desc]]).limit(10)
 @tags=Celeb.alltags
end

def fans
  
end
end
