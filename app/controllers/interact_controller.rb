class InteractController < ApplicationController
  
def index
@celebdiscs= CelebDiscussion.order_by([[:updated,:desc]])
 @tags=Celeb.alltags
end

def fans
  
end
end
