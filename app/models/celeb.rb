class Celeb
  include Mongoid::Document
field :_id ,type: Integer
field :followers,type: Integer
field :friends,type: Integer
field :mentions,type: Integer
field :tags ,type: Array
field :screenName,type: String
field :name,type: String

def self.mosttweetstoday
keyf = <<KEYF
function(doc) {
celeb=db.celebs.findOne({_id : doc.celeb_id})
return {"celeb" : celeb }
 }
KEYF
today = DateTime.now.beginning_of_day.to_i * 1000
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
today = DateTime.now.beginning_of_day.to_i * 1000
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
    where(:time.gte => 10.days.ago.to_i).count
  end

end
end
