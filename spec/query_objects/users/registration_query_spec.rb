# frozen_string_literal: true

RSpec.describe Users::RegistrationQuery do
  let(:instance_class) do
    described_class.new(current_user: current_user, user_params: user_params)
  end
  let(:email) { Faker::Name.first_name + '@gmail.com' }
  let(:password) { Faker::Name.first_name }
  let(:auth_token) { SecureRandom.uuid }
  let(:current_user) do
    create(:user, :admin,
           email: email,
           password: Base64.encode64(password),
           auth_token: auth_token)
  end
  let(:user_params) do
    { email: Faker::Name.first_name + '@gmail.com',
      forward_email: Faker::Name.first_name + '@gmail.com',
      mobile_number: Faker::Number.number(9),
      password: Faker::Number.number(9),
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.first_name }
  end

  context 'with invalid params' do
    let(:current_user) { nil }
    let(:user_params) { nil }

    it 'raise invalid params error ' do
      expect { instance_class.call }.to raise_error(InvalidParamsError)
    end
  end

  context 'with invalid current_user' do
    let(:current_user) do
      create(:user, :user,
             email: email,
             password: Base64.encode64(password),
             auth_token: auth_token)
    end

    it 'raise not admin user error ' do
      expect { instance_class.call }.to raise_error(NotAdminUserError)
    end
  end

  context 'with invalid user_params' do
    let(:user_params) do
      { email: Faker::Name.first_name + '@gmail.com',
        forward_email: Faker::Name.first_name + '@gmail.com',
        mobile_number: Faker::Number.number(9),
        password: nil,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.first_name }
    end

    it 'raise not admin user error ' do
      expect { instance_class.call }.to raise_error(InvalidUserParamsError)
    end
  end

  context 'with valid params' do
    before do
      current_user
    end

    it 'create a new user' do
      expect { instance_class.call }.to change(User, :count).by(1)
    end
  end

  context 'with duplicate user params' do
    before do
      current_user
      instance_class.call
    end

    it 'raises duplicate user' do
      expect { instance_class.call }.to raise_error(DuplicateUserError)
    end
  end
end
