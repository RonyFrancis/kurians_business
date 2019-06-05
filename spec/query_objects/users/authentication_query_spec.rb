# frozen_string_literal: true

RSpec.describe Users::AuthenticationQuery do
  let(:instance_class) do
    described_class.new(email: email, auth_token: auth_token)
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
    let(:auth_token) { nil }

    it 'raise invalid params' do
      expect { instance_class.call }.to raise_error(InvalidAuthParamsError)
    end
  end

  context 'with unauthorised user' do
    before do
      valid_user
    end

    let(:instance_class) do
      described_class.new(email: email, auth_token: incorrect_auth_token)
    end
    let(:incorrect_auth_token) { Faker::Number.number(9) }

    it 'raises invalidCredital error' do
      expect { instance_class.call }.to raise_error(
        UnauthorisedUserError
      )
    end
  end

  context 'with valid_params' do
    before do
      valid_user
    end

    it 'returns authorised user' do
      expect(instance_class.call).to eq(valid_user)
    end
  end
end
