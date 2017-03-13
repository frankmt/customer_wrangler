class User

  attr_reader :intercom_user_id, :email, :name

  def self.find_by_email(email)
    intercom_user = IntercomService.find_user(email)
    return nil unless intercom_user

    self.new({
      email: email,
      name: intercom_user.name,
      intercom_user_id: intercom_user.user_id
    })
  end

  def number_of_orders
    start_date = DateTime.now - (365*4)
    payload = {
      :filters => [{
        "property_name" => "user_id",
        "operator" => "eq",
        "property_value" => self.email
        }],
      :timeframe => {
        :start => start_date,
        :end => DateTime.now
      }
    }
    Keen.count("orders", payload)
  end

  def total_sales
    start_date = DateTime.now - (365*4)
    payload = {
      :target_property => "total",
      :filters => [{
        "property_name" => "user_id",
        "operator" => "eq",
        "property_value" => self.email
      }],
      :timeframe => {
        :start => start_date,
        :end => DateTime.now
      }
    }
    Keen.sum("orders", payload)
  end

  def initialize(params={})
    @intercom_user_id = params[:intercom_user_id]
    @email = params[:email]
    @name = params[:name]
  end
end
