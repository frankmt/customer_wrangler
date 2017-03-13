require_relative '../spec_helper'

RSpec.describe User do

  describe "number of orders" do

    it "should return the number of orders" do
      start_date = DateTime.now - (365 * 4)
      payload = {
        :filters => [{
          "property_name" => "user_id",
          "operator" => "eq",
          "property_value" => "test@user.com"
        }],
        :timeframe => {
          :start => start_date,
          :end => DateTime.now
        }
      }
      expect(Keen).to receive(:count).with("orders", payload).and_return(10)
      user = User.new(email: "test@user.com")
      expect(user.number_of_orders).to eq(10)
    end

  end

  describe "total_sales" do

    it "should return total sales" do
      start_date = DateTime.now - (365 * 4)
      payload = {
        :target_property => "total",
        :filters => [{
          "property_name" => "user_id",
          "operator" => "eq",
          "property_value" => "test@user.com"
        }],
        :timeframe => {
          :start => start_date,
          :end => DateTime.now
        }
      }
      expect(Keen).to receive(:sum).with("orders", payload).and_return(1000)
      user = User.new(email: "test@user.com")
      expect(user.total_sales).to eq(1000)
    end

  end

  describe "loading user from intercom" do

    it 'should return nil if user doesnt exist' do
      expect(IntercomService).to receive(:find_user).and_return nil

      user = User.find_by_email('test@email.com')
      expect(user).to be_nil
    end

    it 'should load user based on email' do
      intercom_user = double("Intercom::User", email: 'test@email.com', user_id: '1234', name: 'John Doe')
      expect(IntercomService).to receive(:find_user).with('test@email.com').and_return intercom_user

      user = User.find_by_email('test@email.com')
      expect(user.email).to eq('test@email.com')
      expect(user.intercom_user_id).to eq('1234')
      expect(user.name).to eq('John Doe')
    end

  end

end
