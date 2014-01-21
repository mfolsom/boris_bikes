require "spec_helper"

describe Garage do
	let(:garage) {Garage.new(:capacity=>25)}
	let(:bike) {Bike.new}


	it "should instantly fix any bike put into it" do
		bike.break
		garage.dock(bike)
		expect(bike).not_to be_broken
	end
	
	it "should allow setting a capacity as soon as it is initialized" do
		expect(garage.capacity).to eq(25)
	end

end