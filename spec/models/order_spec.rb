require_relative '../spec_helper'

RSpec.describe Order do

  it "should initialize correctly" do
    expected_date = DateTime.now
    order = Order.new(date: expected_date, total: 100.10, user_id: 'harry@potter.com')

    expect(order.date).to eq(expected_date)
    expect(order.user_id).to eq('harry@potter.com')
    expect(order.total).to eq(100.10)
  end

end
