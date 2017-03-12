require_relative '../../config/boot.rb'

namespace :fixtures do

  desc 'load orders fixture data in keen environment'
  task :load_orders_data do
    [10,9,8,7,6,5,4,3,2,1].each do |i|
      date = DateTime.now - i
      order = Order.new({
        user_id: 'test@user.com',
        order_id: "R#{rand(9999)}",
        date: date,
        total: 50*i
      })
      Keen.publish('orders',order.to_event)
      puts "published #{date}"
    end

  end

  desc 'load fixture data in intercom environment'
  task :load_intercom_data do
    intercom = Intercom::Client.new(token: ENV['INTERCOM_TOKEN'])

    intercom.users.create(email: "test@user.com", name: "Jerry Seinfeld", signed_up_at: Time.now.to_i)
    intercom.users.create(email: "alice@example.com", name: "Alice Cole", signed_up_at: Time.now.to_i)
  end

end
