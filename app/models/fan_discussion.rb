class FanDiscussions
  include Mongoid::Document
field :_id ,type: Integer
embeds_many :fandisctweets
referenced_in :celebtweet ,:class_name => :fantweet, :foreign_key => 'celeb'
referenced_in :fantweet ,:class_name => :fantweet, :foreign_key => 'fan'
end

class FanDisctweet
  include Mongoid::Document
field :_id ,type: Integer
embedded_in :fandiscussion
referenced_in :fantweet , :foreign_key => '_id'
end

