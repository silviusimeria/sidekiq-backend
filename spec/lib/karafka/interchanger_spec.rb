# frozen_string_literal: true

RSpec.describe Karafka::Interchanger do
  subject(:interchanger_class) { described_class }

  let(:array_params_batch) do
    [
      {
        'value' => 1,
        'parser' => 'Class',
        'receive_time' => 1,
        'a' => 1
      }
    ]
  end
  let(:params_batch) do
    instance_double(
      Karafka::Params::ParamsBatch,
      to_a: array_params_batch
    )
  end

  describe 'encode and decode chain' do
    it 'expects to be able to encode and decode and remain structure' do
      encoded = described_class.encode(params_batch)
      decoded = described_class.decode(encoded)
      expect(decoded).to eq array_params_batch
    end
  end

  describe 'json serialized later params batch' do
    it 'expects to be able to encode and decode and remain structure' do
      encoded = described_class.encode(params_batch).to_json
      decoded = described_class.decode(JSON.parse(encoded))
      expect(decoded[0].to_a - array_params_batch[0].to_a).to be_empty
    end
  end
end
