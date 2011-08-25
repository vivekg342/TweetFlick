class Tweet
  include Mongoid::Document

  field :text,type: String
    field :time,type: Integer

def celeb
  Celeb.first(:id=>Integer(celeb_id))
end
def self.today
  today = DateTime.now.beginning_of_day.to_i * 1000
      where(:time.gte => today).count
end
def link_twitter_user
  @txt= self.text
  if matches = @txt.scan(/.*?(@)((?:[a-z][a-z]+))(:|\s)/i)
    matches.each do |match|
    user = match[1]
    @txt.gsub!(user, '<a target="_blank" href="http://twitter.com/' + user + '">' + user + '</a>')
    end
		
	end
	@txt
end

#   Associations ::::::::::::::::::
    belongs_to:celeb
end
