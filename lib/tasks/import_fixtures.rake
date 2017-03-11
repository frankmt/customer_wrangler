require_relative '../../config/boot.rb'

namespace :fixtures do

  desc 'load orders fixture data in keen environment'
  task :load_orders_data do
    [10,9,8,7,6,5,4,3,2,1].each do |i|
      date = DateTime.now - i
      order = Order.new({
        user_id: 'test@user.com',
        date: date,
        total: 50*i
      })
      Keen.publish('orders',order.to_event)
      puts "published #{date}"
    end

  end

end
