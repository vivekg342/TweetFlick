print("*******  Featured Celeb  ***************");
print(new Date());
var num=db.celebs.count();
var rand=Math.floor(Math.random()*num);
db.featured.remove();
db.celebs.find().skip(rand).limit(1).forEach(
function(f) {print(rand+" - "+f.userName+" : "+f.userScreenName);db.featured.insert(f);});

