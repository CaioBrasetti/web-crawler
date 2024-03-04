class CrawlersController < ApplicationController
  require 'open-uri'
  require 'nokogiri'

  def scrape_quotes(tag)
    if tag.present?
      url = 'https://quotes.toscrape.com/'
      html = URI.open(url)
      doc = Nokogiri::HTML(html)
      filtered_quotes = []

      doc.css('div.quote').each do |quote_element|
        author = quote_element.css('small.author').text
        text = quote_element.css('span.text').text
        tags = quote_element.css('div.tags a.tag').map(&:text)
        quotes = []
        quotes << { author: author, text: text, tags: tags }

        quotes.each do |quote|
          quote[:tags].each do |t|
            if t == tag
              filtered_quotes << quote
              Crawler.create!(author: quote[:author], text: quote[:text], tags: quote[:tags])
            end
          end
        end
      end


      if filtered_quotes.empty?
        empty_tag_error = "Nenhuma citação encontrada com a tag informada. Tente novamente com outra tag."

        render json: { error: empty_tag_error }, status: :not_found if filtered_quotes.empty?
      else
        render json: filtered_quotes, status: :ok
      end
    else
      error_message = 'Por favor, forneça a tag desejada.'

      render json: { error: error_message }, status: :unprocessable_entity
    end
  end
end
