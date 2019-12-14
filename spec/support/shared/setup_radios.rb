shared_context 'setup radios' do
  let(:field_type) { %s(input[type='radio']) }
  let(:aria_described_by_target) { 'fieldset' }
  let(:attribute) { :favourite_colour }
  let(:label_text) { 'Cherished shade' }
end
