shared_examples 'a regular input' do |field_type|
  let(:attribute) { :name }
  let(:label_text) { 'Full name' }
  let(:method) { "govuk_#{field_type}_field".to_sym }

  subject { builder.send(method, :name, label: { text: label_text }) }

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

  specify 'the label should be associated with the input' do
    input_name = parsed_subject.at_css('input')['name']
    label_for = parsed_subject.at_css('label')['for']
    expect(input_name).to eql(label_for)
  end

  context 'when no label is provided' do
    subject { builder.send(method, attribute) }

    specify 'output should contain a label with the capitalised attribute name' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        expect(fg).to have_tag('label', text: attribute.capitalize)
      end
    end
  end

  context 'when a hint is provided' do
    let(:hint) { "You'll find it on your passport" }
    subject { builder.send(method, :name, hint: { text: hint }) }

    specify 'output should contain a hint' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        expect(fg).to have_tag('span', text: hint, with: { class: 'govuk-hint' })
      end
    end

    specify 'output should also contain the label and input elements' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        %w(label input).each { |element| expect(fg).to have_tag(element) }
      end
    end

    specify 'the hint should be associated with the input' do
      input_aria_describedby = parsed_subject.at_css('input')['aria-describedby']
      hint_id = parsed_subject.at_css('span.govuk-hint')['id']
      expect(input_aria_describedby).to eql(hint_id)
    end
  end

  context 'when a hint is not provided' do
    subject { builder.send(method, :name, hint: nil) }

    specify 'output should have no empty aria-describedby attribute' do
      expect(parsed_subject.at_css('span.govuk-hint')).not_to be_present
    end

    specify 'output should have no empty aria-describedby attribute' do
      expect(parsed_subject.at_css('input')['aria-describedby']).not_to be_present
    end
  end

  context 'when the attribute has errors' do
    subject { builder.send(method, :name, hint: nil) }
    before { object.valid? }
    let(:message) { object.errors.messages[:name].join }

    specify 'should have error class' do
      expect(parsed_subject.at_css('.govuk-form-group')['class']).to include('govuk-form-group--error')
    end

    specify 'error message should be present' do
      expect(parsed_subject.at_css('.govuk-error-message').text).to include(message)
    end

    specify 'the error message should be associated with the input' do
      error_id = parsed_subject.at_css('span.govuk-error-message')['id']
      expect(parsed_subject.at_css('input')['aria-describedby'].split).to include(error_id)
    end
  end

  context 'when the attribute has no errors' do
    specify 'should not have error class' do
      expect(parsed_subject.at_css('.govuk-form-group')['class']).not_to include('govuk-form-group--error')
    end

    specify 'error message should not be present' do
      expect(parsed_subject.at_css('.govuk-error-message')).to be_nil
    end

    specify 'the error message should be associated with the input' do
      expect(parsed_subject.at_css('input')['aria-describedby']).to be_empty
    end
  end

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
        subject { builder.send(method, :name, width: identifier) }

        specify "should have the correct class of #{width_class}" do
          expect(parsed_subject.at_css('input')['class']).to include(width_class)
        end
      end
    end
  end

  context 'label styling' do
    context 'font size overrides' do
      {
        'large'   => 'govuk-!-font-size-48',
        'medium'  => 'govuk-!-font-size-36',
        'small'   => 'govuk-!-font-size-27',
        'regular' => nil
      }.each do |size_name, size_class|
        context "#{size_name} labels" do
          let(:size_name) { size_name }
          let(:size_class) { size_class }
          subject { builder.send(method, :name, label: { size: size_name }) }

          if size_class.present?
            specify "should have extra class '#{size_class}'" do
              expect(extract_classes(parsed_subject, 'label')).to include(size_class)
            end
          else
            specify 'should have no extra size classes' do
              expect(extract_classes(parsed_subject, 'label')).to eql(%w(govuk-label))
            end
          end
        end
      end
    end

    context 'font weight overrides' do
      {
        'bold'    => 'govuk-!-font-weight-bold',
        'regular' => nil
      }.each do |weight_name, weight_class|
        context "#{weight_name} labels" do
          let(:weight_name) { weight_name }
          let(:weight_class) { weight_class }
          subject { builder.send(method, :name, label: { weight: weight_name }) }

          if weight_class.present?
            specify "should have extra class '#{weight_class}'" do
              expect(extract_classes(parsed_subject, 'label')).to include(weight_class)
            end
          else
            specify 'should have no extra weight classes' do
              expect(extract_classes(parsed_subject, 'label')).to eql(%w(govuk-label))
            end
          end
        end
      end
    end
  end
end
