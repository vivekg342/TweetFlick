class FanTweet
  include Mongoid::Document

  field :reply_to,type: Integer
  field :time,type: Integer
  def self.today
      where(:time.gte => 1.days.ago.to_i).count
end
end
