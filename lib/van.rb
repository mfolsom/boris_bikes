class Van
	include BikeContainer

	# def initialize(capacity: capacity, **options)
	# 	self.capacity = capacity
	# end

	def initialize(options ={})
		self.capacity = options.fetch(:capacity, capacity) 
	end

	def load_broken_bikes(station)
		station.broken_bikes.each do |bike|
			break if self.full? 
			station.release(bike)
			self.dock(bike)
		end

	end

	def load_fixed_bikes(garage)
		garage.available_bikes.each do |bike|
			break if self.full?
			garage.release(bike)
			self.dock(bike)
		end
	end

	def unload_bikes(container)
		self.bikes.dup.each do |bike|
			break if container.full?
			self.release(bike)
			container.dock(bike)
		end
	end
end