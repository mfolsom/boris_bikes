require "spec_helper"

describe Van do
	let(:van) {Van.new(capacity: 5)}
	let(:station) {DockingStation.new}
	let(:garage) {Garage.new}

	def fill_holder(station, number)
		number.times {station.dock(Bike.new)}
	end

	def break_bikes(station)
		station.bikes.each { |bike| bike.break }
	end

	it "should allow setting of capacity as it is initialized" do
		expect(van.capacity).to eq(5)
	end

	it "should get all the broken bikes from the docking station" do
		working_bike, broken_bike, broken_bike2 = Bike.new, Bike.new, Bike.new
		broken_bike.break
		broken_bike2.break
		station.dock(working_bike)
		station.dock(broken_bike)
		station.dock(broken_bike2)
		van.load_broken_bikes(station)
		expect(station.bikes).to eq([working_bike])
		expect(van.bikes).to eq([broken_bike,broken_bike2])
	end

	it "should only accept the number of bikes it can carry" do
		fill_holder(station, 10)
		break_bikes(station)
		van.load_broken_bikes(station)
		expect(station.bike_count).to eq(5)
		expect(van.bike_count).to eq(5)
	end

	it "should be able to unload bikes" do
		bike1,bike2, bike3 = Bike.new, Bike.new, Bike.new
		bike2.break
		van.dock(bike1)
		van.dock(bike2)
		van.dock(bike3)
		van.unload_bikes(station)
		expect(van).to be_empty
		expect(station.bikes).to eq([bike1,bike2, bike3])
	end

	it "should stop unloading once the container is full" do
		fill_holder(van, 5)
		fill_holder(station, 7)
		van.unload_bikes(station)
		expect(van.bike_count).to eq(2)
		expect(station.bike_count).to eq(10)
	end


	it "should accept fixed bikes from the garage" do
		bike1, bike2, bike3 = Bike.new, Bike.new, Bike.new
		garage.dock(bike1)
		garage.dock(bike2)
		garage.dock(bike3)
		van.load_fixed_bikes(garage)
		expect(garage).to be_empty
		expect(van.bikes).to eq([bike1,bike2,bike3])
	end

	it "should only accept the number of fixed bikes it can carry" do
		fill_holder(garage, 10)
		van.load_fixed_bikes(garage)
		expect(garage.bike_count).to eq(5)
		expect(van.bike_count).to eq(5)
	end
end