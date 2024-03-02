class CrawlersController < ApplicationController
  require 'open-uri'
  require 'nokogiri'

  def scrape_quotes
    url = 'https://quotes.toscrape.com/'
    html = URI.open(url)
    doc = Nokogiri::HTML(html)

    doc.css('div.quote').each do |quote_element|
      author = quote_element.css('small.author').text
      text = quote_element.css('span.text').text
      tags = quote_element.css('div.tags a.tag').map(&:text)

      Crawler.create!(author: author, text: text, tags: tags)

      puts "Author: #{author}"
      puts "Text: #{text}"
      puts "Tags: #{tags.join(', ')}"
      puts "-------------"
    end
  end
end
