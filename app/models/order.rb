require 'date'

class Order

  attr_reader :user_id, :date, :total

  def initialize(params={})
    @user_id = params[:user_id]
    @date = params[:date]
    @total = params[:total]
  end

end
