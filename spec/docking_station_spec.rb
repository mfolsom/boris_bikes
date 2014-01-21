
require "spec_helper"

describe DockingStation do
	let(:station) {DockingStation.new(capacity: 123)}

	it "should allow setting capacity on initialising" do
		expect(station.capacity).to eq(123)
	end
end