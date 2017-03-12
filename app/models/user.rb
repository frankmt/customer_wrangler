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

  def initialize(params={})
    @intercom_user_id = params[:intercom_user_id]
    @email = params[:email]
    @name = params[:name]
  end
end
