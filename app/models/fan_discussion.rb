class FanDiscussions
  include Mongoid::Document
field :_id ,type: Integer
embeds_many :fandisctweets
referenced_in :atweet ,:class_name => :tweet, :foreign_key => 'celeb'
referenced_in :btweet ,:class_name => :fantweet, :foreign_key => 'fan'
end

class FanDisctweet
  include Mongoid::Document
field :_id ,type: Integer
embedded_in :fandiscussion
referenced_in :fantweet , :foreign_key => '_id'
end

