class Garage 
	include BikeContainer

	def initialize(capacity: capacity, **options)
		self.capacity = capacity
	end

	def dock(bike)
		bike.fix
		super 
	end
end