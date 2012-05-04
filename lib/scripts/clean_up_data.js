print("**********  Removing fan tweets   ************");
print(new Date());

var date = new Date();
date.setMonth(date.getMonth()-1);

//Remove fan tweets older than one month

db.fan_tweets.remove({time : {$lt : date.getTime() }})

//Remove celeb tweets older than 3 months
print("******** Removing celeb tweets **************");
print(new Date());

var date = new Date();
date.setMonth(date.getMonth()-3);
db.tweets.remove({time : {$lt : date.getTime() }})


