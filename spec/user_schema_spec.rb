require_relative './spec_helper.rb'
require_relative '../lib/user_schema.rb'

RSpec.describe UserSchema do
  subject(:schema) { described_class.get }

  describe '#call' do
    subject(:validation_result) { schema.call attributes }
    let(:attributes) { { score: score, subscribed: subscribed } }
    let(:score) { '14' }
    let(:subscribed) { 'true' }

    context 'when score is NOT coercible to integer' do
      let(:score) { '17.44' }

      it 'is failure' do
        expect(validation_result).to be_failure
      end
    end

    context 'when subscribed is NOT coercible to boolean' do
      let(:subscribed) { 'hello' }

      it 'is failure' do
        expect(validation_result).to be_failure
      end
    end

    context 'when score and subscribed are coercible to correct types' do
      it 'is succuess' do
        expect(validation_result).to be_success
      end
    end
  end
end

