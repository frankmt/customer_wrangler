require_relative 'event'

class Message < Event

  def self.find_by_period(user, start_date, end_date)
    [2,4,6,8].map do |days_ago|
      date = DateTime.now - days_ago
      details = {first_message: "Hello..."}
      Message.new(date: date, user_id: user, details: details)
    end
  end

  def initialize(params={})
    @main_type = 'conversation'
    @sub_type = 'message'

    @date = params[:date]
    @details = params[:details]
  end

end
