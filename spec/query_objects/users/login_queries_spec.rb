# frozen_string_literal: true

RSpec.describe Users::LoginQueries do
  let(:instance_class) do
    described_class.new(email: email, password: password)
  end
  let(:email) { Faker::Name.first_name + '@gmail.com' }
  let(:password) { Faker::Number.number(10) }
  let(:valid_user) { create(:user, :admin, email: email, password: Base64.encode64(password) ) }

  context 'with invalid params' do
    let(:email) { nil }
    let(:password) { nil }

    it 'raises invalidCredital error' do
      expect { instance_class.call }.to raise_error(InvalidLoginError)
    end
  end

  context 'with user not registered' do
    before do
      valid_user
    end

    let(:instance_class) do
      described_class.new(email: email, password: incorrect_password)
    end
    let(:incorrect_password) { Faker::Number.number(9) }

    it 'raises invalidCredital error' do
      expect { instance_class.call }.to raise_error(
        IncorrectCredentialsError
      )
    end
  end

  context 'with valid params' do
    before do
      valid_user
    end

    it 'return the valid_user' do
      expect(instance_class.call).to eq(valid_user)
    end
  end
end
