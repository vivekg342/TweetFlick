class CelebDiscussion
  include Mongoid::Document
field :_id ,type: Integer
field :atweet_id , type: Integer
field :btweet_id , type: Integer

referenced_in  :atweet ,:foreign_key => 'atweet_id' , :class_name => 'Tweet'
referenced_in  :btweet , :foreign_key => 'btweet_id' , :class_name => 'Tweet'
embeds_many :disctweets
end

class Disctweet
  include Mongoid::Document
field :_id ,type: Integer
referenced_in  :tweet , :foreign_key => '_id'
embedded_in :celebdiscussion , :class_name => 'Tweet'
end

