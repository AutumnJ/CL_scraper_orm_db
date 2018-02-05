class RoomScraper

	def initialize(index_url)
		@doc = Nokogiri::HTML(open(index_url))
		#binding.pry
	end

	def call
		rows.each do |row_doc| #named to remind us this comes back as a nokogiri 'doc'
			Room.create_from_hash(scrape_row(row_doc)) #references another method that breaks row down
			#should insert room in database = otherwise could use .new and then .save, but would involve an additional variable:
			# room = Room.new_from_hash(scrape_row(row_doc))
			# room.save
		end	
	end

	private
	def rows
		@rows ||= @doc.search("div.content ul.rows p.result-info") #.css and .search are aliases of one another
		# ||= or equals operator 
		# stops at left side if that is true - ruby will return whichever value makes this true
	end

	def scrape_row(row_doc)
		#can drop whole hash into console when in pry to see what values return
		{
			:date_created => row_doc.search("time").attribute("datetime").text,
			:title => row_doc.search("a.hdrlnk").text,
			:url => row_doc.search("a.hdrlnk").attribute("href").value, #.text is the same as .value here
			:price => row_doc.search("span.result-price").text
		}
	end
end

#time is: @doc.search("time.result-date")