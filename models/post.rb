class Post
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :url, URI
  property :content, Text
  property :date_published, DateTime

  belongs_to :category

  before :create do
    classifier = Classifier.new
    classifier.train(content, category.name)
  end
end
