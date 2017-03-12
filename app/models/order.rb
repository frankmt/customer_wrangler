class Order

  attr_reader :order_id, :user_id, :date, :total, :details

  def self.find_by_period(user, start_date, end_date)
    payload = {
      :filters => [{
        "property_name" => "user_id",
        "operator" => "eq",
        "property_value" => user
      }],
      :timeframe => {
        :start => start_date,
        :end => end_date
      }
    }

    response = ::Keen.extraction("orders", payload)
    response.map{|order_payload| Order.from_event(order_payload)}
  end

  def initialize(params={})
    @order_id = params[:order_id]
    @user_id = params[:user_id]
    @date = params[:date]
    @total = params[:total]
    @details = params[:details]
  end

  def to_event
    {
      order_id: @order_id,
      user_id: @user_id,
      total: @total,
      date: {
        week_number: @date.strftime('%U').to_i,
        month: @date.strftime('%m').to_i,
        week_day: @date.strftime('%w').to_i,
        year: @date.strftime('%Y').to_i,
        date: @date.iso8601
      },
      details: @details,
      keen: {
        timestamp: @date.iso8601
      }
    }
  end

  private

  def self.from_event(payload)
    Order.new({
      order_id: payload["order_id"],
      user_id: payload["user_id"],
      date: DateTime.parse(payload["date"]["date"]),
      total: payload["total"],
      details: payload["details"]
    })
  end

end
