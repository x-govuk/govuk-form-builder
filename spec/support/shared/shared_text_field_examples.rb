shared_examples 'a regular input' do |method_identifier, field_type|
  let(:attribute) { :name }
  let(:label_text) { 'Full name' }
  let(:hint_text) { 'It says it on your passport' }
  let(:method) { "govuk_#{method_identifier}_field".to_sym }
  let(:args) { [method, :name] }
  subject { builder.send(*args, label: { text: label_text }) }

  specify "output should have the correct type of #{field_type}" do
    expect(subject).to have_tag('input', with: { type: field_type })
  end

  specify 'output should be form group containing a label and input' do
    expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
      expect(fg).to have_tag('label', text: label_text)
      expect(fg).to have_tag('input')
    end
  end

  let(:field_type) { 'input' }
  let(:aria_described_by_target) { 'input' }

  include_examples 'HTML formatting checks'

  it_behaves_like 'a field that supports labels'
  it_behaves_like 'a field that supports labels as procs'
  it_behaves_like 'a field that supports captions on the label'
  it_behaves_like 'a field that supports hints'
  it_behaves_like 'a field that supports custom branding'
  it_behaves_like 'a field that contains a customisable form group'

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
  it_behaves_like 'a field that supports setting the label caption via localisation'
  it_behaves_like 'a field that supports setting the hint via localisation'

  it_behaves_like 'a field that accepts a plain ruby object' do
    let(:described_element) { 'input' }
  end

  it_behaves_like 'a field that allows extra HTML attributes to be set' do
    let(:described_element) { 'input' }
    let(:expected_class) { 'govuk-input' }
  end

  it_behaves_like 'a field that allows nested HTML attributes to be set' do
    let(:described_element) { 'input' }
    let(:expected_class) { 'govuk-input' }
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

  describe 'affixes' do
    let(:prefix_text) { '£' }
    let(:suffix_text) { 'per item' }

    shared_examples 'prefixes' do
      specify 'the wrapper and prefix should be present' do
        expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do
          with_tag('div', with: { class: 'govuk-input__wrapper' }) do
            with_tag('span', with: { class: 'govuk-input__prefix', 'aria-hidden': true }, text: prefix_text)
            with_tag('input')
          end
        end
      end
    end

    shared_examples 'suffixes' do
      specify 'the wrapper and suffix should be present' do
        expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do
          with_tag('div', with: { class: 'govuk-input__wrapper' }) do
            with_tag('span', with: { class: 'govuk-input__suffix', 'aria-hidden': true }, text: suffix_text)
            with_tag('input')
          end
        end
      end
    end

    shared_examples 'no prefix' do
      specify 'prefix should not be present' do
        expect(subject).not_to have_tag('span', with: { class: 'govuk-input__prefix' })
        expect(subject).to have_tag('input')
      end
    end

    shared_examples 'no suffix' do
      specify 'suffix should not be present' do
        expect(subject).not_to have_tag('span', with: { class: 'govuk-input__suffix' })
        expect(subject).to have_tag('input')
      end
    end

    context 'when a prefix is supplied' do
      subject { builder.send(*args, prefix_text: prefix_text) }

      include_examples 'prefixes'
      include_examples 'no suffix'
    end

    context 'when a suffix is supplied' do
      subject { builder.send(*args, suffix_text: suffix_text) }

      include_examples 'suffixes'
      include_examples 'no prefix'
    end

    context 'when both a prefix and suffix are supplied' do
      subject { builder.send(*args, prefix_text: prefix_text, suffix_text: suffix_text) }

      include_examples 'prefixes'
      include_examples 'suffixes'
    end

    context 'when neither a prefix or suffix is supplied' do
      subject { builder.send(*args) }

      include_examples 'no prefix'
      include_examples 'no suffix'
    end
  end
end
