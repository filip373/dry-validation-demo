shared_examples 'application schema' do
  subject(:validation_result) { schema.call attributes }

  context 'when attributes contains tags attribute' do
    context 'and tags are string' do
      let(:tags) { 'string' }

      it 'is failure' do
        expect(validation_result).to be_failure
      end

      it 'contains error with invalid type message' do
        expect(validation_result.errors).to include(tags: ['must be an array'])
      end
    end

    context 'and tags are array' do
      context 'which is empty' do
        let(:tags) { [] }

        it 'is success' do
          expect(validation_result).to be_success
        end

        it 'does NOT contain errors' do
          expect(validation_result.errors).to be_empty
        end
      end

      context 'which contains only strings' do
        let(:tags) { ['first', 'second'] }

        it 'is success' do
          expect(validation_result).to be_success
        end

        it 'does NOT contain errors' do
          expect(validation_result.errors).to be_empty
        end
      end

      context 'which contains some integer' do
        let(:tags) { ['first', 5] }

        it 'is failure' do
          expect(validation_result).to be_failure
        end

        it 'does NOT contain errors' do
          expect(validation_result.errors).to include(tags: { 1 => ['must be a string'] })
        end
      end
    end
  end
end
