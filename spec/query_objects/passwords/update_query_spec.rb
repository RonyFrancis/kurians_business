# frozen_string_literal: true

RSpec.describe Passwords::UpdateQuery do
  let(:instance_class) do
    described_class.new(
      user_name: email,
      old_password: old_password,
      new_password: new_password
    )
  end
  let(:email) { Faker::Name.first_name + '@gmail.com' }
  let(:old_password) { Faker::Name.first_name }
  let(:new_password) { Faker::Name.first_name }
  let(:auth_token) { SecureRandom.uuid }
  let(:valid_user) do
    create(:user, :admin,
           email: email,
           password: Base64.encode64(old_password),
           auth_token: auth_token)
  end

  context 'with invalid params' do
    let(:email) { nil }
    let(:old_password) { nil }

    it 'raise invalid params error' do
      expect { instance_class.call }.to raise_error(InvalidParamsError)
    end
  end

  context 'with invalid old_password params' do
    before do
      valid_user
    end

    let(:instance_class) do
      described_class.new(
        user_name: email,
        old_password: new_password,
        new_password: new_password
      )
    end

    it 'raise invalid temp password error' do
      expect { instance_class.call }.to raise_error(
        InvalidTempPasswordError
      )
    end
  end

  context 'with valid old_password params' do
    before do
      valid_user
    end

    it 'updates the user record' do
      expect { instance_class.call }.to change{
         User.last.password
       }.from(Base64.encode64(old_password)).to(Base64.encode64(new_password))
    end
  end
end
