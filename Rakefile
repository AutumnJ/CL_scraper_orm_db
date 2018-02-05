require_relative './config/environment'

def reload!
	load_all './lib'
end


task :console do
	Pry.start
end

task :scrape_rooms do
	#instantiate scraper & have it find new rooms
	chicago_scraper = RoomScraper.new('https://chicago.craigslist.org/search/roo')
	chicago_scraper.call
	#after this method call, should be able to say Room.all and have rooms there
end