describe GOVUKDesignSystemFormBuilder::FormBuilder do
  let(:field_type) { 'input' }
  let(:aria_described_by_target) { 'fieldset' }

  include_context 'setup builder'
  let(:attribute) { :favourite_colour }
  let(:label_text) { 'Cherished shade' }

  describe '#govuk_collection_radio_buttons' do
    let(:method) { :govuk_collection_radio_buttons }
    let(:colours) do
      [
        OpenStruct.new(id: 'red', name: 'Red', description: red_hint),
        OpenStruct.new(id: 'blue', name: 'Blue', description: blue_hint),
        OpenStruct.new(id: 'green', name: 'Green'),
        OpenStruct.new(id: 'yellow', name: 'Yellow')
      ]
    end

    let(:args) { [method, attribute, colours, :id, :name] }
    subject { builder.send(*args) }

    specify 'output should be a form group containing a form group and fieldset' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        expect(fg).to have_tag('fieldset', with: { class: 'govuk-fieldset' })
      end
    end

    it_behaves_like 'a field that supports a fieldset with legend' do
      let(:legend_text) { 'Pick your favourite colour' }
    end

    it_behaves_like 'a field that supports hints' do
      let(:hint_text) { 'The colour of your favourite handkerchief' }
    end

    it_behaves_like 'a field that supports errors' do
      let(:error_message) { /Choose a favourite colour/ }
      let(:error_class) { nil }
      let(:error_identifier) { 'person-favourite-colour-error' }
    end

    it_behaves_like 'a field that accepts arbitrary blocks of HTML'

    context 'radio buttons' do
      specify 'each radio button should have the correct classes' do
        expect(subject).to have_tag('input', with: { class: %w(govuk-radios__input) }, count: colours.size)
      end

      specify 'each label should have the correct classes' do
        expect(subject).to have_tag('label', count: colours.size, with: { class: %w(govuk-label govuk-radios__label) })
      end

      specify 'there should be the correct number' do
        expect(subject).to have_tag('input', count: colours.size, with: { type: 'radio' })
        expect(subject).to have_tag('label', count: colours.size)
      end

      specify 'radio buttons should be surrounded by a radios module' do
        expect(subject).to have_tag('div', with: { 'data-module' => 'radios' }) do |dm|
          expect(dm).to have_tag('input', count: colours.size, with: { type: 'radio' })
        end
      end

      specify 'each radio button should have the correct id' do
        colours.each do |colour|
          "person-favourite-colour-#{colour.id}-field".tap do |association|
            expect(subject).to have_tag('input', with: { id: association })
          end
        end
      end

      specify 'radio buttons should have the correct name' do
        parsed_subject.css('input').each do |input|
          expect(input['name']).to eql('person[favourite_colour]')
        end
      end

      specify 'radio buttons should be associated with corresponding labels' do
        colours.each do |colour|
          "person-favourite-colour-#{colour.id}-field".tap do |association|
            expect(subject).to have_tag('input', with: { id: association })
            expect(subject).to have_tag('label', with: { for: association })
          end
        end
      end

      context 'radio button hints' do
        let(:colours_with_descriptions) { colours.select { |c| c.description.present? } }
        let(:colours_without_descriptions) { colours.reject { |c| c.description.present? } }

        subject { builder.send(*args.push(:description)) }

        specify 'the radio buttons with hints should contain hint text' do
          expect(subject).to have_tag('span', count: colours_with_descriptions.size, with: { class: 'govuk-hint govuk-radios__hint' })
        end

        specify 'the hint should be associated with the correct radio button' do
          colours_with_descriptions.each do |cwd|
            "person-favourite-colour-#{cwd.id}-hint".tap do |association|
              expect(subject).to have_tag('input', with: { "aria-describedby" => association })
              expect(subject).to have_tag('span', with: { class: 'govuk-hint', id: association })
            end
          end
        end

        specify 'radio buttons without hints shouldn not have aria-describedby attributes' do
          colours_without_descriptions.each do |cwd|
            "person-favourite_colour-#{cwd.id}-hint".tap do |association|
              expect(subject).not_to have_tag('input', with: { "aria-describedby" => association })
            end
          end
        end
      end

      context 'layout direction' do
        context 'when inline is specified in the options' do
          subject do
            builder.send(method, attribute, colours, :id, :name, :description, inline: true)
          end

          specify "should have the additional class 'govuk-radios--inline'" do
            expect(subject).to have_tag('div', with: { class: %w(govuk-radios govuk-radios--inline) })
          end
        end

        context 'when inline is not specified in the options' do
          subject do
            builder.send(method, attribute, colours, :id, :name, :description, inline: false)
          end

          specify "should not have the additional class 'govuk-radios--inline'" do
            expect(parsed_subject.at_css('.govuk-radios')['class']).to eql('govuk-radios')
          end
        end
      end

      context 'radio button size' do
        context 'when small is specified in the options' do
          subject do
            builder.send(method, attribute, colours, :id, :name, :description, small: true)
          end

          specify "should have the additional class 'govuk-radios--small'" do
            expect(subject).to have_tag('div', with: { class: %w(govuk-radios govuk-radios--small) })
          end
        end

        context 'when small is not specified in the options' do
          subject do
            builder.send(method, attribute, colours, :id, :name, :description, small: false)
          end

          specify "should not have the additional class 'govuk-radios--small'" do
            expect(parsed_subject.at_css('.govuk-radios')['class']).to eql('govuk-radios')
          end
        end
      end
    end
  end

  describe '#govuk_radio_buttons_fieldset' do
    let(:method) { :govuk_radio_buttons_fieldset }
    let(:args) { [method, attribute] }

    subject do
      builder.send(*args) do
        builder.safe_join(
          [
            builder.govuk_radio_button(:favourite_colour, :red, label: { text: red_label }),
            builder.govuk_radio_button(:favourite_colour, :green, label: { text: green_label })
          ]
        )
      end
    end

    context 'when no block is supplied' do
      subject { builder.send(*args) }
      specify { expect { subject }.to raise_error(NoMethodError, /undefined method.*call/) }
    end

    it_behaves_like 'a field that accepts arbitrary blocks of HTML'

    it_behaves_like 'a field that supports errors' do
      let(:error_message) { /Choose a favourite colour/ }
      let(:error_class) { nil }
      let(:error_identifier) { 'person-favourite-colour-error' }
    end

    context 'when a block containing radio buttons is supplied' do
      specify 'output should be a form group containing a form group and fieldset' do
        expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
          expect(fg).to have_tag('fieldset', with: { class: 'govuk-fieldset' })
        end
      end

      specify 'output should contain radio buttons' do
        expect(subject).to have_tag('div', with: { class: 'govuk-radios', 'data-module' => 'radios' }) do
          expect(subject).to have_tag('input', with: { type: 'radio' }, count: 2)
        end
      end

      context 'layout direction' do
        context 'when inline is specified in the options' do
          subject do
            builder.send(*args.push(inline: true)) do
              builder.govuk_radio_button(:favourite_colour, :red, label: { text: red_label })
            end
          end

          specify "should have the additional class 'govuk-radios--inline'" do
            expect(subject).to have_tag('div', with: { class: %w(govuk-radios govuk-radios--inline) })
          end
        end

        context 'when inline is not specified in the options' do
          subject do
            builder.send(*args) do
              builder.govuk_radio_button(:favourite_colour, :red, label: { text: red_label })
            end
          end

          specify "should have no additional classes" do
            expect(parsed_subject.at_css('.govuk-radios')['class']).to eql('govuk-radios')
          end
        end
      end

      context 'radio button size' do
        context 'when small is specified in the options' do
          subject do
            builder.send(*args.push(small: true)) do
              builder.govuk_radio_button(:favourite_colour, :red, label: { text: red_label })
            end
          end

          specify "should have the additional class 'govuk-radios--small'" do
            expect(subject).to have_tag('div', with: { class: %w(govuk-radios govuk-radios--small) })
          end
        end

        context 'when small is not specified in the options' do
          subject do
            builder.send(*args) do
              builder.govuk_radio_button(:favourite_colour, :red, label: { text: red_label })
            end
          end

          specify "should not have the additional class 'govuk-radios--small'" do
            expect(parsed_subject.at_css('.govuk-radios')['class']).to eql('govuk-radios')
          end
        end
      end

      context 'dividers' do
        subject do
          builder.send(*args) do
            builder.govuk_radio_divider
          end
        end

        specify "should output a 'or' divider by default" do
          expect(subject).to have_tag('div', text: 'or', with: { class: %w(govuk-radios__divider) })
        end

        context 'when divider text overridden' do
          let(:other_text) { 'alternatively' }
          subject do
            builder.send(method, attribute) do
              builder.govuk_radio_divider(other_text)
            end
          end

          specify "should output a divider containing the supplied text" do
            expect(subject).to have_tag('div', text: other_text, with: { class: %w(govuk-radios__divider) })
          end
        end
      end
    end
  end

  describe '#govuk_radio_button' do
    let(:method) { :govuk_radio_button }
    let(:value) { 'red' }
    let(:args) { [method, attribute, value] }

    subject { builder.send(*args) }

    specify 'output should contain a radio item group with a radio input' do
      expect(subject).to have_tag('div', with: { class: 'govuk-radios__item' }) do |ri|
        expect(ri).to have_tag('input', with: { type: 'radio', value: value })
      end
    end

    it_behaves_like 'a field that supports labels' do
      let(:label_text) { 'Red' }
      let(:field_type) { 'input' }

      specify 'the label should have a radios label class' do
        expect(subject).to have_tag('label', with: { class: 'govuk-radios__label' })
      end
    end

    context 'radio button hints' do
      subject do
        builder.govuk_radio_button(:favourite_colour, :red, hint_text: red_hint)
      end

      specify 'should contain a hint with the correct text' do
        expect(subject).to have_tag('span', text: red_hint)
      end

      specify 'the hint should have the correct classes' do
        expect(subject).to have_tag('span', with: { class: %w(govuk-hint govuk-radios__hint) })
      end
    end

    context 'conditionally revealing content' do
      context 'when a block is given' do
        subject do
          builder.govuk_radio_button(:favourite_colour, :red) do
            builder.govuk_text_field(:favourite_colour_reason)
          end
        end

        specify 'should include content provided in the block in a conditional div' do
          expect(subject).to have_tag('div', with: { class: 'govuk-radios__conditional govuk-radios__conditional--hidden' }) do |cd|
            expect(cd).to have_tag('label', with: { class: 'govuk-label' }, text: 'Favourite_colour_reason')
            expect(cd).to have_tag('input', with: { type: 'text' })
          end
        end

        specify "the data-aria-controls attribute should match the conditional block's id" do
          input_data_aria_controls = parsed_subject.at_css("input[type='radio']")['data-aria-controls']
          conditional_id = parsed_subject.at_css('div.govuk-radios__conditional')['id']
          expect(input_data_aria_controls).to eql(conditional_id)
        end

        specify 'conditional_id contains the object, attribute and value name' do
          expect(
            parsed_subject.at_css("input[type='radio']")['data-aria-controls']
          ).to eql('person-favourite-colour-red-conditional')
        end
      end

      context 'when no block is given' do
        subject { builder.govuk_radio_button(:favourite_colour, :red) }

        specify "the data-aria-controls attribute should be blank" do
          input_data_aria_controls = parsed_subject.at_css("input[type='radio']")['data-aria-controls']
          expect(input_data_aria_controls).to be_nil
        end

        specify "the conditional container should not be present" do
          expect(subject).not_to have_tag('.govuk-radios__conditional')
        end
      end
    end
  end
end
