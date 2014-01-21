require "spec_helper"

describe Van do
	let(:van) {Van.new(capacity: 5)}
	let(:station) {DockingStation.new}

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
end