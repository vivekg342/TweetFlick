

xml.instruct!

xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  @celebs.each do |celeb|
    xml.url do
       xml.loc profile_path(:name => celeb.screenName,:only_path => false)
     xml.lastmod Time.now.to_date
    xml.changefreq "always"
    end
  end
#starting from Jan,1 2011
startDate=1293820200000 # 8.months.ago.beginning_of_day.to_i
today=0.days.ago.beginning_of_day.to_i * 1000
date=startDate

##########today##########
xml.url do
       xml.loc archive_tweets_path(:time => today,:only_path => false)
     xml.lastmod Time.now.to_date
    xml.changefreq "always"
    end
#########archives#############
while date < today
  xml.url do
       xml.loc archive_tweets_path(:time => date,:only_path => false)
     xml.lastmod Time.at(date/1000).to_date
    xml.changefreq "weekly"
    end
  date += 86400000
end
end
