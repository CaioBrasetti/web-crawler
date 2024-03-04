class CrawlersController < ApplicationController
  require 'open-uri'
  require 'nokogiri'

  def search_tag_into_database(tag)
    results_with_tag = Crawler.where(tag: tag).to_a

    return results_with_tag if results_with_tag.present?

    quotes = scrape_quotes_in_website(tag)

    filtered_quotes = []

    quotes.each do |quote|
      quote[:tags].each do |t|
        if t == tag
          filtered_quotes << quote
          Crawler.find_or_create_by(author: quote[:author], text: quote[:text], tag: tag)
        end
      end
    end

    filtered_quotes
  end

  def scrape_quotes_in_website(tag)
    if tag.present?
      url = 'https://quotes.toscrape.com/'
      html = URI.open(url)
      doc = Nokogiri::HTML(html)
      quotes = []

      doc.css('div.quote').each do |quote_element|
        author = quote_element.css('small.author').text
        text = quote_element.css('span.text').text
        tags = quote_element.css('div.tags a.tag').map(&:text)
        quotes << { author: author, text: text, tags: tags }
      end

      quotes
    end
  end

  def scrape_quotes_with_tag(tag)
    if tag.present?
      filtered_quotes = search_tag_into_database(tag)
      error_message = "Nenhuma citação encontrada com a tag informada. Tente novamente com outra tag."

      filtered_quotes.empty? ? render_json(error_message, :not_found) : render json: filtered_quotes, status: :ok
    else
      error_message = 'Por favor, forneça a tag desejada.'

      render_json(error_message, :unprocessable_entity)
    end
  end

  private

  def render_json(error_message, status)
    render json: { error: error_message }, status: status
  end
end
