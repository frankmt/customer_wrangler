require_relative '../spec_helper'

RSpec.describe Order do

  describe "loading orders from keen" do

    let(:response){[{
      "date" => {
        "date"=>"2017-03-05T22:55:00+11:00",
        "week_day" => 0,
        "year" => 2017,
        "week_number" => 10,
        "month" => 3
      },
      "keen" => {
        "timestamp" => "2017-03-05T11:55:00.000Z",
        "created_at"=>"2017-03-11T11:55:00.591Z",
        "id"=>"58c3e59472c177677115fc67"
      },
      "total" => 300,
      "user_id" => "test@user.com",
      "details" => nil
    }]}

    it 'should be empty if there are no results' do
      expect(Keen).to receive(:extraction).and_return([])
      orders = Order.find_by_period("crazy@user.com", DateTime.now, DateTime.now)
      expect(orders).to be_empty
    end

    it "should load based on date and user" do
      start_date = DateTime.now - 7
      end_date = DateTime.now

      payload = {
        :filters => [{
          "property_name" => "user_id",
          "operator" => "eq",
          "property_value" => "test@user.com"
        }],
        :timeframe => {
          :start => start_date,
          :end => end_date
        }
      }
      expect(Keen).to receive(:extraction).with("orders", payload).and_return(response)
      orders = Order.find_by_period("test@user.com", start_date, end_date)
      expect(orders.count).to eq(1)
      expect(orders.first.user_id).to eq("test@user.com")
      expect(orders.first.total).to eq(300)
    end

  end

  it "should initialize correctly" do
    expected_date = DateTime.now
    order = Order.new(date: expected_date, total: 100.10, user_id: 'harry@potter.com')

    expect(order.date).to eq(expected_date)
    expect(order.user_id).to eq('harry@potter.com')
    expect(order.total).to eq(100.10)
  end

  it "should accept custom custom" do
    details = {item_total: 90, delivery_fee: 7.99, first_name: 'Harry'}
    order = Order.new(details: details)

    expect(order.details[:item_total]).to eq(90)
    expect(order.details[:delivery_fee]).to eq(7.99)
    expect(order.details[:first_name]).to eq('Harry')
  end

  describe 'keen format' do

    it 'should format for keen import' do
      expected_date = DateTime.now
      details = {item_total: 90, delivery_fee: 7.99, first_name: 'Harry'}
      order = Order.new(date: expected_date, total: 100.10, user_id: 'harry@potter.com', details: details)

      event = order.to_event
      expect(event[:user_id]).to eq('harry@potter.com')
      expect(event[:total]).to eq(100.10)

      expect(event[:date][:week_number]).to eq(expected_date.strftime('%U').to_i)
      expect(event[:date][:month]).to eq(expected_date.strftime('%m').to_i)
      expect(event[:date][:week_day]).to eq(expected_date.strftime('%w').to_i)
      expect(event[:date][:year]).to eq(expected_date.strftime('%Y').to_i)
      expect(event[:date][:date]).to eq(expected_date.iso8601)

      expect(event[:details][:item_total]).to eq(90)
      expect(event[:details][:delivery_fee]).to eq(7.99)
      expect(event[:details][:first_name]).to eq('Harry')

      expect(event[:keen][:timestamp]).to eq(expected_date.iso8601)
    end

  end

end
