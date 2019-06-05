# frozen_string_literal: true

RSpec.describe Users::LoginQueries do
  let(:instance_class) do
    described_class.new(email: email, password: password)
  end

  context 'with invalid params' do
    let(:email) { nil }
    let(:password) { nil }

    it 'raises invalidCredital error' do
      expect { instance_class }.to raise_error
    end
  end

  context 'with user not registered' do
  end

  context 'with valid params' do
  end
end
