class BiDailyTaskJob < ApplicationJob
  queue_as :default

  def perform
    quotes = Crawler.all.pluck(:tag).to_a
    
    quotes.each do |quote_tag|
      CrawlersController.new.search_tag_into_database(quote_tag)
    end
  end
end
