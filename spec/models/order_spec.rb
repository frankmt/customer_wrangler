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

end
