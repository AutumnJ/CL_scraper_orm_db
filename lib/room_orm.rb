#commenting this out as the room class that inherits from ActiveRecord::Base now has access to these

# class Room

# 	attr_accessor :title, :date_created, :price, :url, :id

# 	def self.create_from_hash(hash) #instantiate and save
# 		new_from_hash(hash).save
# 	end

# 	def self.new_from_hash(hash) #just instantiating
# 		room = self.new
# 		room.title = hash[:title]
# 		room.date_created = hash[:date_created]
# 		room.price = hash[:price]
# 		room.url = hash[:url]

# 		room #see usage of tap in method below - this prevents us from having to return a local variable at end of method
# 	end

# 	def self.new_from_db(row)
# 		self.new.tap do |room| #this returns block level variable, tighter scope than local variable
# 			room.id = row[0]
# 			room.title = row[1]
# 			room.date_created = row[2]
# 			room.price = row[3]
# 			room.url = row[4]
# 		end
# 	end

# 	def self.all
# 		sql = <<-SQL
# 			SELECT * FROM rooms;
# 		SQL

# 		rows = DB[:connection].execute(sql) #take data out of database

# 		self.new_from_rows(rows)
# 	end

# 	def self.new_from_rows(rows) #collection constructor
# 		rows.collect do |row|   #for each row, instantiate an object; using collect, instances will be return value
# 			self.new_from_db(row)
# 		end
# 	end

# 	def save
# 		insert #eventually create update || insert, otherwise each database entry is not necessarily unique
# 	end

# 	def insert 
# 		puts "You are about to save #{self}"
# 		sql = <<-SQL
# 			INSERT INTO rooms (title, date_created, price, url) VALUES (?, ?, ?, ?)
# 		SQL

# 		DB[:connection].execute(sql, self.title, self.date_created, self.price, self.url)
# 	end

# 	def self.create_table
# 		sql = <<-SQL
# 		CREATE TABLE IF NOT EXISTS rooms (
# 			id INTEGER PRIMARY KEY,
# 			title TEXT,
# 			date_created DATETIME,
# 			price TEXT,
# 			url TEXT
# 		)
# 		SQL

# 		DB[:connection].execute(sql)
# 	end

# 	#Acting on objects instantiated from database

# 	# def self.by_price(order = "ASC")
# 	# 	case order
# 	# 	when "ASC"
# 	# 		self.all.sort_by {|row| row.price}
# 	# 	when "DESC"
# 	# 		self.all.sort_by {|row| row.price}.reverse
# 	# 	end
# 	# end

# 	def self.by_price(order = "ASC")
# 		sql = <<-SQL
# 			SELECT * FROM rooms ORDER BY price #{order} #even though this interpolation is greyed out, it does work
# 		SQL

# 		rows = DB[:connection].execute(sql) #take data out of database

# 		self.new_from_rows(rows)
# 	end	

# end