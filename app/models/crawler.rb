class Crawler
  include Mongoid::Document
  include Mongoid::Timestamps
  field :author, type: String
  field :text, type: String
  field :tags, type: String
end
