require 'date'

class Order

  attr_reader :user_id, :date, :total, :details

  def initialize(params={})
    @user_id = params[:user_id]
    @date = params[:date]
    @total = params[:total]
    @details = params[:details]
  end

  def to_event
    {
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

end
