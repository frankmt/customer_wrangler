require 'singleton'

class IntercomService
  include Singleton

  def self.find_user(email)
    begin
      instance.intercom.users.find(email: email)
    rescue Intercom::ResourceNotFound
      nil
    end
  end


  def intercom
    @intercom ||= Intercom::Client.new(token: ENV['INTERCOM_TOKEN'])
  end

end
