require_relative '../spec_helper'

RSpec.describe Order do

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
