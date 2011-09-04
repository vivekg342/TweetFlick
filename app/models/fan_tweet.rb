class FanTweet
  include Mongoid::Document

  field :reply_to,type: String
  field :time,type: Integer
  def self.today
     # today = 1.days.ago.to_i * 1000
    today = 0.days.ago.beginning_of_day.to_i * 1000
      where(:time.gte => today).count
end
  def self.todayby(name)
    #  today = 1.days.ago.to_i * 1000
    today = 0.days.ago.beginning_of_day.to_i * 1000
      where(:reply_to => name, :time.gte => today).count
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
def self.weekstats
keyf = <<KEYF
function(doc) {
var weekday=new Array("Sun","Mon","Tue","Wed","Thu",
                "Fri","Sat")
                myDate = new Date(doc.time *1)
return {"day" : weekday[myDate.getDay()],"index":myDate.getDate()  }

 }
KEYF
#sixdays = 6.days.ago.to_i * 1000
sixdays = 4.days.ago.beginning_of_day.to_i * 1000
cond = {:time => {'$gte' => sixdays }}
reduce = <<REDUCE
  function(key,values){
values.tweets+=1;
}
REDUCE
array=FanTweet.collection.group( {:keyf => keyf,:cond => cond ,:initial => {tweets:0},:reduce => reduce})
array.sort {|a,b| a["index"] <=> b["index"]}
end

   
belongs_to :fandiscussion
 belongs_to:fandisctweet
end
