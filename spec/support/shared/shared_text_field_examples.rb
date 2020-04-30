shared_examples 'a regular input' do |method_identifier, field_type|
  let(:attribute) { :name }
  let(:label_text) { 'Full name' }
  let(:hint_text) { 'It says it on your passport' }
  let(:method) { "govuk_#{method_identifier}_field".to_sym }
  let(:args) { [method, :name] }
  subject { builder.send(*args, label: { text: label_text }) }

  specify "output should have the correct type of #{field_type}" do
    input_type = parsed_subject.at_css('input')['type']
    expect(input_type).to eql(field_type)
  end

  specify 'output should be form group containing a label and input' do
    expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
      expect(fg).to have_tag('label', text: label_text)
      expect(fg).to have_tag('input')
    end
  end

  let(:field_type) { 'input' }
  let(:aria_described_by_target) { 'input' }

  it_behaves_like 'a field that supports labels'

  it_behaves_like 'a field that supports hints'

  it_behaves_like 'a field that accepts arbitrary blocks of HTML' do
    let(:described_element) { 'input' }
  end

  it_behaves_like 'a field that supports errors' do
    let(:object) { Person.new(name: nil) }

    let(:error_message) { /Enter a name/ }
    let(:error_class) { 'govuk-input--error' }
    let(:error_identifier) { 'person-name-error' }
  end

  it_behaves_like 'a field that supports setting the label via localisation'
  it_behaves_like 'a field that supports setting the hint via localisation'

  it_behaves_like 'a field that accepts a plain ruby object' do
    let(:described_element) { 'input' }
  end

  context 'extra attributes' do
    let(:regular_args) { { label: { text: 'What should we call you?' } } }

    let(:extra_args) do
      {
        required: { provided: true, output: 'required' },
        autocomplete: { provided: false, output: 'false' },
        placeholder: { provided: 'Seymour Skinner', output: 'Seymour Skinner' }
      }
    end

    subject do
      builder.send(*args, **regular_args.merge(extract_args(extra_args, :provided)))
    end

    specify 'input tag should have the extra attributes' do
      input_tag = parsed_subject.at_css('input')
      extract_args(extra_args, :output).each do |key, val|
        expect(input_tag[key]).to eql(val)
      end
    end
  end

  describe 'width' do
    context 'custom widths' do
      {
        20               => 'govuk-input--width-20',
        10               => 'govuk-input--width-10',
        5                => 'govuk-input--width-5',
        4                => 'govuk-input--width-4',
        3                => 'govuk-input--width-3',
        2                => 'govuk-input--width-2',
        'full'           => 'govuk-!-width-full',
        'three-quarters' => 'govuk-!-width-three-quarters',
        'two-thirds'     => 'govuk-!-width-two-thirds',
        'one-half'       => 'govuk-!-width-one-half',
        'one-third'      => 'govuk-!-width-one-third',
        'one-quarter'    => 'govuk-!-width-one-quarter'
      }.each do |identifier, width_class|
        context "when the width is #{identifier}" do
          let(:identifier) { identifier }
          let(:width_class) { width_class }
          subject { builder.send(*args, width: identifier) }

          specify "should have the correct class of #{width_class}" do
            expect(parsed_subject.at_css('input')['class']).to include(width_class)
          end
        end
      end
    end

    context 'invalid widths' do
      let(:invalid_width) { 'extra-medium' }
      subject { builder.send(method, :name, width: invalid_width) }

      specify 'invalid widths should fail' do
        expect { subject }.to raise_error(ArgumentError, /invalid width/)
      end
    end
  end
end
