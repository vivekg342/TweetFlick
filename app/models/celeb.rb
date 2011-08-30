class Celeb
  include Mongoid::Document
field :_id ,type: Integer
field :followers,type: Integer
field :friends,type: Integer
field :mentions,type: Integer
field :tags ,type: Array
field :screenName,type: String
field :name,type: String

def title_page
  tagStr=self.tags.join(" #{self.name},")+" #{self.name}"
"#{self.name}-Follow #{self.name} and all your favourite celebs on Tweetflick. Check out #{self.name} tweets ,#{self.name} pics,#{self.name} mentions, follow #{self.name} ,#{tagStr}"
end
def keywords
    tagStr=self.tags.join(" #{self.name},")+" #{self.name}"
      tagStr2=self.tags.join(" #{self.name} tweets,")+" #{self.name}"
  "#{self.name} twitter, #{self.name} twitter id, #{self.name} tweets,#{self.name} pictures, #{self.name} replies,#{self.name} mentions on twitter, #{self.name} stats, celebrity #{self.name}, #{self.screenName} twitter,#{self.name} bollywood, #{self.name} tollywood, #{tagStr}, #{tagStr2}"
end
def description
   "Tweets from #{self.name} using his id #{self.screenName}. See all the tweets from #{self.name},replies, retweets, images etc. See who are mentioning and retweeting #{self.name} 's tweets and know more about your favorite celebrity #{self.name}"
end
def large
self.profileImgUrl.gsub!(/_([a-z0-9-]+).(png|gif|jpg|jpeg|JPG|JPEG|GIF|PNG)/, '.\2')
end
def self.random
       # Grabs a random entry from the MongoDB Entry.
       # Returns an array
 Celeb.skip(rand(Celeb.count)).first
end

def self.weekstats
keyf = <<KEYF
 function(doc) {
var weekday=new Array("Sun","Mon","Tue","Wed","Thu",
                "Fri","Sat")
                myDate = new Date(doc.time+475200)
                a=new Date(doc.time+475200)
                a.setHours(0);
                a.setMinutes(0);
                a.setSeconds(0);
                a.setMilliseconds(0);

return {"day" : weekday[myDate.getDay()],"index":myDate.getDate(),"epoch":a.getTime()  }

 }
KEYF
sixdays = 4.days.ago.beginning_of_day.to_i * 1000
#sixdays = 6.days.ago.to_i * 1000
cond = {:time => {'$gte' => sixdays }}
reduce = <<REDUCE
  function(key,values){
values.tweets+=1;
}
REDUCE
array=Tweet.collection.group( {:keyf => keyf,:cond => cond ,:initial => {tweets:0},:reduce => reduce})
array.sort {|a,b| a["index"] <=> b["index"]}
end

def self.mosttweetstoday
keyf = <<KEYF
function(doc) {
celeb=db.celebs.findOne({_id : doc.celeb_id})
return {"celeb" : celeb }
 }
KEYF
today = 0.days.ago.beginning_of_day.to_i * 1000
#today = 1.days.ago.to_i * 1000
cond = {:time => {'$gte' => today }}
reduce = <<REDUCE
  function(key,values){
values.tweets+=1;
}
REDUCE

array=Tweet.collection.group( {:keyf => keyf,:cond => cond ,:initial => {tweets:0},:reduce => reduce}).delete_if {|doc| doc["celeb"].nil?}
array.sort {|a,b| b["tweets"] <=> a ["tweets"]}
end
def self.mostmentionedtoday
keyf = <<KEYF
function(doc) {
celeb=db.celebs.findOne({screenName : doc.reply_to})
return {"celeb" : celeb }
 }
KEYF
#today = 1.days.ago.to_i * 1000
today = 0.days.ago.beginning_of_day.to_i * 1000
cond = {:time => {'$gte' => today }}
reduce = <<REDUCE
  function(key,values){
values.tweets+=1;
}
REDUCE
  array=FanTweet.collection.group( {:keyf => keyf,:cond => cond ,:initial => {tweets:0},:reduce => reduce}).delete_if {|doc| doc["celeb"].nil?}
array.sort {|a,b| b["tweets"] <=> a ["tweets"]}
end


  def self.alltags
     tags = Mongoid.master.collection('tags').find().first["value"]["tags"].split(/,/).to_a.uniq
  end
  def self.rebuild_tags
    map = <<MAP
      function() {
          emit({}, {tags: this.tags})
        }
MAP

    reduce = <<REDUCE
    function(key, values) {
       var arr=new Array
 values.forEach(function(doc){
 arr=arr+","+doc.tags
 })
 return {tags:arr};
 }
REDUCE

    collection.mapreduce(map, reduce,{:out => "tags"})

  end

has_many :tweets do
  def today
  #  today = 1.days.ago.to_i * 1000
  today = 0.days.ago.beginning_of_day.to_i * 1000
    where(:time.gte => today).count
  end

end
end
