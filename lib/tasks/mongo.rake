task "mongo:clean" => :environment do
  scr = open("./lib/scripts/clean_up_data.js", &:read)
  db = Mongoid::Config::master
  result = db.command({:$eval => scr})
end


task "mongo:feature" => :environment do
  scr = open("./lib/scripts/featured.js", &:read)
  db = Mongoid::Config::master
  result = db.command({:$eval => scr})
end