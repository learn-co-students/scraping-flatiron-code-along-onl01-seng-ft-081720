require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

  # attr_accessor :title, :schedule, :description

  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
    # binding.pry
  end

  def get_courses
    self.get_page.css(".post")
    # binding.pry
  end

  def make_courses
    courses = self.get_courses
    courses.each do |div|
      # binding.pry
      course = Course.new
      course.title = div.css("h2").text
      course.schedule = div.css(".date").text
      course.description = div.css("p").text
    end
  end
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end

Scraper.new.print_courses
