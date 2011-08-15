class Celeb
  include Mongoid::Document
field :_id ,type: Integer
field :followers,type: Integer
field :friends,type: Integer
field :tags ,type: Array
field :screenName,type: String
  def today
    tweets.today
  end
  def firChar
  screenName.to_s.chars.first
  end

has_many :tweets do
  def today
    where(:time.gte => 10.days.ago.to_i).count
  end

end
end
