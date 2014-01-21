require "spec_helper"

class ContainerHolder; include BikeContainer; end

describe BikeContainer do
	
	let(:bike) {Bike.new}
	let(:holder) {ContainerHolder.new}

	def fill_holder(holder)
		10.times {holder.dock(Bike.new)}
	end

	it "should accept a bike" do
		expect(holder.bike_count).to eq(0)
		holder.dock(bike)
		expect(holder.bike_count).to eq(1)
	end

	it "should release a bike" do
		holder.dock(bike)
		holder.release(bike)
		expect(holder.bike_count).to eq(0)
	end

	it "should not release a bike if there are no bikes" do
		expect(holder.bike_count).to eq(0)
		expect{holder.release(bike)}.to raise_error(RuntimeError)
	end
	it "should not release a bike if it was given cookies to release" do
		fill_holder holder
		expect{holder.release("cookies")}.to raise_error(RuntimeError)
	end
	it "should not release a bike if that bike isn't in the holder" do
		bike1 = Bike.new
		bike2 = Bike.new
		holder.dock(bike1)
		expect{holder.release(bike2)}.to raise_error(RuntimeError)
	end		

	it "should know when it's empty" do
		expect(holder).to be_empty
	end

	it "should know when it's full" do
		expect(holder).not_to be_full
		fill_holder holder
		expect(holder).to be_full
	end

	it "should not accept a bike if it is full" do
		fill_holder holder
		expect(lambda {holder.dock(bike)}).to raise_error(RuntimeError)
	end

	it "should provide the list of available bikes" do
		working_bike, broken_bike = Bike.new, Bike.new
		broken_bike.break
		holder.dock(working_bike)
		holder.dock(broken_bike)
		expect(holder.available_bikes).to eq([working_bike])
	end
end