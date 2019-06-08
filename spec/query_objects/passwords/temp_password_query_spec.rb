# frozen_string_literal: true

RSpec.describe Passwords::TempPasswordQuery do
  let(:instance_class) do
    described_class.new(
      email: email
    )
  end
  let(:email) { Faker::Name.first_name + '@gmail.com' }
  let(:password) { Faker::Name.first_name }
  let(:auth_token) { SecureRandom.uuid }
  let(:valid_user) do
    create(:user, :admin,
           email: email,
           password: Base64.encode64(password),
           auth_token: auth_token)
  end

  context 'with invalid params' do
    let(:email) { nil }

    it 'raise invalid params error' do
      expect { instance_class.call }.to raise_error(InvalidParamsError)
    end
  end

  context 'with invalid email address' do
    before do
      valid_user
    end
    let(:instance_class) do
      described_class.new(
        email: incorrect_email
      )
    end
    let(:incorrect_email) { Faker::Name.first_name + '@gmail.com' }

    it 'raises user not found error' do
      expect { instance_class.call }.to raise_error(UserNotFoundError)
    end
  end

  context 'with valid params' do
    before do
      valid_user
    end

    it 'updates the user password' do
      expect(instance_class.call).to eq(true)
    end
  end
end
