class Van
	include BikeContainer

	def initialize(capacity: capacity, **options)
		self.capacity = capacity
	end

	def load_broken_bikes(station)
		station.broken_bikes.each do |bike|
			station.release(bike)
			self.dock(bike)
		end
	end

end