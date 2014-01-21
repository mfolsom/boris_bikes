module BikeContainer

DEFAULT_CAPACITY = 10

	def bikes
		@bikes ||= []
	end

	def capacity
		@capacity ||= DEFAULT_CAPACITY
	end
	
	def capacity=(value)
		@capacity = value
	end

	def bike_count
		bikes.count
	end

	def dock(bike)
		raise "Station is full" if full?
		raise "That's not a bike" if !bike.is_a? Bike
		bikes << bike
	end

	def release(bike)
		raise "There are no bikes to release!" if empty?
		raise "That's not a bike!" if !bike.is_a? Bike
		raise "The bike isn't here" if !bikes.include? bike
		bikes.delete(bike)
	end

	def full?
		bike_count == capacity
	end

	def empty?
		bike_count == 0
	end

	def available_bikes
		bikes.reject {|bike| bike.broken?}
	end

	def broken_bikes
		bikes.select {|bike| bike.broken?}
	end
end