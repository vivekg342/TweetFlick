function key(celeb1,celeb2){
try{
if(celeb1 > celeb2) return celeb1 +''+celeb2
else return celeb2 +''+celeb1
}
catch(err)
{
print("error in key"+err);
}
}


function Days(days) {
d= new Date((new Date()).getTime() - days*24*60*60*1000);
return d.getTime();
}

//WARNING :: REMOVING COLLECTIONS
db.celeb_discussions.remove();
db.fan_discussions.remove();
var keys=[];
var count=0;
var twodays=Days(4);
db.tweets.find({reply_to_tweet :{$gt : 0 }}).forEach(function(c){
var celeb1=db.celebs.findOne({_id:c.celeb_id });
var  rtot=c.reply_to_tweet;
 var tweet =  db.tweets.findOne({_id : rtot });
if(tweet && celeb1){

 celeb2=db.celebs.findOne({_id:tweet.celeb_id });
if(celeb2){
 k= key(celeb1._id,celeb2._id)
  if(keys.indexOf(k)<0){
  keys.push(k);
  print(celeb1.screenName +'--' +celeb2.screenName);
arr= db.tweets.find({reply_to :{$ne : null} ,$or :[{celeb_id: celeb1._id , reply_to:celeb2.screenName} ,{celeb_id: celeb2._id , reply_to:celeb1.screenName}]},{_id:1});
  try{
  db.celeb_discussions.insert({_id:parseInt(k), atweet_id:c._id , btweet_id: tweet._id , disctweets : arr.toArray(),updated:c.time});
  }catch(err) {print("err saving "+err);}
}
}
}
else
{
try{
        var tweet =  db.fan_tweets.findOne({_id : rtot});
         if(tweet && celeb1){
        k= key(celeb1._id,tweet.fan_id)
         if(keys.indexOf(k)<0){
          keys.push(k);
          print(celeb1.screenName +'--' +tweet.screenName);

          arr= db.fan_tweets.find({fan_id: tweet.fan_id , reply_to:celeb1.screenName,time :{$gte:twodays}},{_id:1});
arr2=db.tweets.find({celeb_id:c.celeb_id , reply_to:tweet.screenName},{_id:1});
        db.fan_discussions.insert({_id:parseInt(k), celeb_id:c._id , fan_id: tweet._id ,disctweets:arr2.toArray(), fan_disctweets : arr.toArray(),updated:c.time});
}
}
}catch(err){print(err);}
}
});

