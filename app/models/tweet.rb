class Tweet
  include Mongoid::Document

  field :text,type: String
    field :time,type: Integer

def celeb
  Celeb.first(:id=>Integer(celeb_id))
end
def self.today
      where(:time.gte => 1.days.ago.to_i).count
end
#   Associations ::::::::::::::::::
    belongs_to:celeb
end
