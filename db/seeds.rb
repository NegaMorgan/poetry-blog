# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'nokogiri'
require 'open-uri'

#poems = PoemScraper.new(25)

class PoemScraper
  def initialize(number_of_poems)
    @poems = PoemFinder.list(25)
    @poems.each do |poem|
      
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