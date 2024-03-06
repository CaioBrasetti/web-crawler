class Crawler
  include Mongoid::Document
  include Mongoid::Timestamps
  field :quote, type: String
  field :author, type: String
  field :author_about, type: String
  field :tag, type: String
  field :related_tags, type: String
end
