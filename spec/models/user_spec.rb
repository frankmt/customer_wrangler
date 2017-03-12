require_relative '../spec_helper'

RSpec.describe User do

  describe "loading user from intercom" do

    it 'should return nil if user doesnt exist' do
      expect(IntercomService).to receive(:find_user).and_return nil

      user = User.find_by_email('test@email.com')
      expect(user).to be_nil
    end

    it 'should load user based on email' do
      intercom_user = double("Intercom::User", email: 'test@email.com', user_id: '1234', name: 'John Doe')
      expect(IntercomService).to receive(:find_user).with('test@email.com').and_return intercom_user

      user = User.find_by_email('test@email.com')
      expect(user.email).to eq('test@email.com')
      expect(user.intercom_user_id).to eq('1234')
      expect(user.name).to eq('John Doe')
    end

  end

end
