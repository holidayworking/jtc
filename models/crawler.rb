require 'feed-normalizer'
require 'nokogiri'
require 'open-uri'

class Crawler
  def initialize(category, url)
    @category = category
    @url = url
  end

  def run
    feed = FeedNormalizer::FeedNormalizer.parse(open(@url))
    feed.entries.each do |entry|
      url = entry.urls.first.sub(/\?ref=rss/, '')
      next if Post.first(:url => url)

      content = extract_content(url)
      next if content.empty?

      category = Category.first_or_create(:name => @category)

      post = Post.create(
        :title          => entry.title,
        :url            => url,
        :content        => content,
        :category       => category,
        :date_published => entry.date_published
      )
    end
  end

  def extract_content(url)
    begin
      doc = Nokogiri::HTML(open(url).read, nil, 'EUC-JP')
      return doc.css('#HeadLine .BodyTxt').inner_text.gsub(/\n/, '')
    rescue
      return ''
    end
  end

  def self.run
    FEED.each do |category, url|
      crawler = Crawler.new(category, url)
      crawler.run
    end
  end
end
