class FanTweet
  include Mongoid::Document

  field :reply_to,type: Integer
  field :time,type: Integer
  def self.today
      where(:time.gte => 1.days.ago.to_i).count
end

def link_twitter_user
  @txt= self.text
  if matches = @txt.scan(/.*?(@)((?:[a-z][a-z]+))(:|\s)/i)
    matches.each do |match|
    user = match[1]
    @txt.gsub!(user, '<a href="http://twitter.com/' + user + '">' + user + '</a>')
    end
		
	end
	@txt
end
end
