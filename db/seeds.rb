# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'

class PoemScraper
  def initialize(number_of_poems)
    @poems = PoemFinder.list(number_of_poems)
    @poems.each do |poem_link|
      page = Nokogiri::HTML(open(poem_link))
      poem = Poem.new
      poem.title = page.css(".poem-detail h2.title").first.text
      # TODO refactor poem.content to preserve line endings
      poem.content = page.css(".poem-detail div.KonaBody").text
      author_name = page.css(".poet").text
      poem.author = Author.find_or_create_by(:name => author_name)
      poem.save
    end
  end
end 

class PoemFinder
  BASE_URL = "http://www.poemhunter.com"
  # TODO make number of poems dynamic, search multiple pages
  def self.list(number_of_poems)
    page = Nokogiri::HTML(open(BASE_URL+"/p/m/l.asp?p=1&l=Top500&order=title"))
    page.css(".poems-listing .title a").collect { |link| BASE_URL+link.attribute("href").value }
  end
end

poems = PoemScraper.new(25)