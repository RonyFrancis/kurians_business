RSpec.describe ResponseFormatter do
  let(:instance_class) do
    described_class.new(
      code: code, message: message,
      data: data, version: version
    )
  end
  let(:code) { 200 }
  let(:message) { 'success' }
  let(:data) do
    {}
  end
  let(:version) { 1 }

  context 'with invalid params' do
    it 'return formatted default values' do
      expect(instance_class.call).to eq({
        code: code,
        message: message,
        data: data,
        version: version
      })
    end
  end

  context 'with valid params' do
    let(:code) { 1 }
    let(:message) { 'failure' }

    it 'return formated given values' do
      expect(instance_class.call).to eq({
        code: code,
        message: message,
        data: data,
        version: version
      })
    end
  end
end
