class Photo
  include Mongoid::Document

  field :url,type: String
    field :time,type: Integer

def imglink
  :url
end
def celeb
  Celeb.first(:id=>Integer(celeb_id))
end
#   Associations ::::::::::::::::::
    belongs_to:celeb
end
