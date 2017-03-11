require_relative '../../main.rb'
require 'keen'

namespace :fixtures do

  desc 'load orders fixture data in keen environment'
  task :load_orders_data do
    Keen.project_id = "58c3d76395cfc91c2b8e4d4d"
    Keen.write_key = "3D1CF63A243E9A24BEA69B9EDE675D9439C72DBEC85658C0B51B2BD677BA9175E3C3F49E53B0CCBF3D2B9D635ED038901A7CC60FBBE46F7C23E2048E110F30A2C432388F8E44BBC8F20898C9BA1EEF905F87E38C67E7CDA16DD577A2BA54070D"

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
