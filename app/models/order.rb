require 'date'

class Order

  attr_reader :user_id, :date, :total, :details

  def initialize(params={})
    @user_id = params[:user_id]
    @date = params[:date]
    @total = params[:total]
    @details = params[:details]
  end

end
