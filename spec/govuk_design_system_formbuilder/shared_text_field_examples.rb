shared_examples 'a regular input' do |field_type|
  let(:helper) { TestHelper.new }
  let(:object) { Person.new }
  let(:object_name) {:person}
  let(:builder) { described_class.new(object_name, object, helper, {})}
  let(:parsed_subject) { Nokogiri.parse(subject) }

  let(:attribute) { :name }
  let(:label) { 'Full name' }
  let(:method) { "govuk_#{field_type}_field".to_sym }

  subject { builder.send(method, :name, { label: label }) }

  specify "output should have the correct type of #{field_type}" do
    input_type = parsed_subject.at_css('input')['type']
    expect(input_type).to eql(field_type)
  end

  specify 'output should be form group containing a label and input' do
    expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
      expect(fg).to have_tag('label', text: label)
      expect(fg).to have_tag('input')
    end
  end

  specify 'the label should be associated with the input' do
    input_name = parsed_subject.at_css('input')['name']
    label_for = parsed_subject.at_css('label')['for']
    expect(input_name).to eql(label_for)
  end

  context 'when no label is provided' do
    subject { builder.govuk_text_field(attribute) }

    specify 'output should contain a label with the capitalised attribute name' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        expect(fg).to have_tag('label', text: attribute.capitalize)
      end
    end
  end

  context 'when a hint is provided' do
    let(:hint) { "You'll find it on your passport" }
    subject { builder.send(method, :name, { hint: hint }) }

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
    subject { builder.send(method, :name, { hint: nil }) }

    specify 'output should have no empty aria-describedby attribute' do
      expect(parsed_subject.at_css('span.govuk-hint')).not_to be_present
    end

    specify 'output should have no empty aria-describedby attribute' do
      expect(parsed_subject.at_css('input')['aria-describedby']).not_to be_present
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
          subject { builder.send(method, :name, { label_size: size_name }) }


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
          subject { builder.send(method, :name, { label_weight: weight_name }) }

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
