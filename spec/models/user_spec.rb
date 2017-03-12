require_relative '../spec_helper'

RSpec.describe User do

  describe "loading user from intercom" do

    it 'should return nil if user doesnt exist' do
    end

    it 'should load user based on email' do
      expect(IntercomService).to receive(:find_user).and_return nil

      user = User.find_by_email('test@email.com')
      expect(user).to be_nil
    end

  end

end
