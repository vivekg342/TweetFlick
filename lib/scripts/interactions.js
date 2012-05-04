var keyf=function(doc) {
celeb=db.celebs.findOne({_id : doc.celeb_id})
return {"celeb" : celeb }
 };
 var reduce= function(key,values){
values.tweets+=1;
};

var result=db.tweets.group({
keyf:keyf,
initial:{tweets:0},
reduce:reduce,
 cond: { reply_to:{$ne:"null"} }
 });

 for( i=0;i<result.length;i++){
 if(result[i]["celeb"]){
 print(result[i]["celeb"].screenName +"---"+ result[i]["tweets"]);
 }
 }

