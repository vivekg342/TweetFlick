class FanTweet
  include Mongoid::Document

  field :reply_to,type: Integer
  field :time,type: Integer
  def self.today
      today = DateTime.now.beginning_of_day.to_i * 1000
      where(:time.gte => today).count
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
def self.weekstats
keyf = <<KEYF
 function(doc) {
var weekday=new Array("Sun","Mon","Tue","Wed","Thu",
                "Fri","Sat")
                myDate = new Date(doc.time *1).getDay()
return {"day" : weekday[myDate],"index":myDate  }

 }
KEYF
sixdays = 6.days.ago.beginning_of_day.to_i * 1000
cond = {:time => {'$gte' => sixdays }}
reduce = <<REDUCE
  function(key,values){
values.tweets+=1;
}
REDUCE
array=FanTweet.collection.group( {:keyf => keyf,:cond => cond ,:initial => {tweets:0},:reduce => reduce})

end


end
