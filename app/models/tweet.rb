class Tweet
  include Mongoid::Document

  field :text,type: String

def celeb
  Celeb.first(:id=>Integer(celeb_id))
end
#   Associations ::::::::::::::::::
    belongs_to:celeb
end
