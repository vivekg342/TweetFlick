class Suggest
  include Mongoid::Document
field :_id ,type: Integer
field :name,type: String
field :userName,type: String 
field :email,type: String
field :comments,type: String
end
