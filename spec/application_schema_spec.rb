require_relative './spec_helper.rb'
require_relative './shared_examples/application_schema.rb'
require_relative '../lib/application_schema.rb'

RSpec.describe ApplicationSchema do
  subject(:schema) { described_class.new }

  describe '#call' do
    let(:attributes) { { tags: tags } }
    it_behaves_like 'application schema'
  end
end
