

xml.instruct!

xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  @celebs.each do |celeb|
    xml.url do
       xml.loc url_for(:controller => 'celebs',:action => 'show',:id => celeb.id)
     xml.lastmod Time.now.to_date
    xml.changefreq "always"
    end
    xml.url do
       xml.loc profile_path(:name => celeb.screenName)
     xml.lastmod Time.now.to_date
    xml.changefreq "always"
    end
  end
end