require_relative './spec_helper.rb'
require_relative './shared_examples/application_schema.rb'
require_relative '../lib/car_schema.rb'

RSpec.describe CarSchema do
  subject(:schema) { described_class.get }

  describe '#call' do
    describe 'application schema inheritance' do
      let(:attributes) { { tags: tags, color: 'blue', year: 1990 } }
      it_behaves_like 'application schema'
    end

    describe 'extending attributes' do
      subject(:validation_result) { schema.call attributes }
      let(:attributes) { { color: color, year: year } }
      let(:color) { 'blue' }
      let(:year) { 1990 }

      context 'when color is NOT filled' do
        let(:color) { nil }

        it 'is failure' do
          expect(validation_result).to be_failure
        end

        it 'contains correct errors' do
          expect(validation_result.errors).to include(color: ['must be given in each case'])
        end
      end

      context 'when color is filled' do
        it 'is success' do
          expect(validation_result).to be_success
        end
      end

      context 'when year is NOT int' do
        let(:year) { '1990' }

        it 'is failure' do
          expect(validation_result).to be_failure
        end
      end

      context 'when year is below 1900' do
        let(:year) { 1890 }

        it 'is failure' do
          expect(validation_result).to be_failure
        end
      end

      context 'when year is tomorrow' do
        let(:year) { Date.today + 1 }

        it 'is failure' do
          expect(validation_result).to be_failure
        end
      end

      context 'when year and color are valid' do
        it 'is success' do
          expect(validation_result).to be_success
        end
      end

      context 'when driver is filled' do
        before { attributes.merge! driver: driver }

        context 'and name is in the correct format' do
          let(:driver) { 'driver-#23' }

          it 'is success' do
            expect(validation_result).to be_success
          end
        end

        context 'and name is NOT in the correct format' do
          let(:driver) { 'other-driver' }

          it 'is failure' do
            expect(validation_result).to be_failure
          end
        end
      end

      context 'when consumption is filled' do
        before { attributes.merge! consumption: { city: city, highway: highway } }
        let(:city) { 20 }
        let(:highway) { 10 }

        context 'when city is nil' do
          let(:city) { nil }

          it 'is success' do
            expect(validation_result).to be_success
          end
        end

        context 'when highway is nil' do
          let(:highway) { nil }

          it 'is success' do
            expect(validation_result).to be_success
          end
        end

        context 'when city and highway are NOT nil' do
          context 'and highway is more than city' do
            let(:highway) { 30 }

            it 'is failure' do
              expect(validation_result).to be_failure
            end
          end

          context 'and city is more than highway' do
            let(:city) { 30 }

            it 'is success' do
              expect(validation_result).to be_success
            end
          end
        end
      end
    end
  end
end
