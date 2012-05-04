// Delete based on n no of tweets per celeb

print("**********************");
print(new Date());
db.celebs.find().forEach(function(c){
        var celebName = c.screenName;
        try{
                var oldest = db.fan_tweets.find({reply_to:celebName}).limit(1).skip(200).sort({ time: -1 }).next();
                var c = db.fan_tweets.count({reply_to:celebName, time : {$lt : oldest.time }})
                print("removing:"+c+" for "+celebName);
                db.fan_tweets.remove({reply_to:celebName, time : {$lt : oldest.time }})
                }catch(err){
      //print("Looks like "+celebName+" has lesser than 500 mentions");
              }
              });

