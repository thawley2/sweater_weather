require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should have_secure_password }

  describe 'before_create' do
    it 'sets an api_key' do
      user = User.create!(email: 'whatever@example.com', password: 'password')

      expect(user.api_key).to be_a String
    end
  end
end