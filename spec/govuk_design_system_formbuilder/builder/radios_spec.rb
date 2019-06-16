describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  let(:attribute) { :favourite_colour }
  let(:label_text) { 'Cherished shade' }
  let(:red_label) { 'Rosso' }
  let(:green_label) { 'Verde' }
  let(:red_hint) { 'Roses are red' }
  let(:blue_hint) { 'Violets are... purple?' }

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

    subject { builder.send(method, attribute, colours, :id, :name) }

    specify 'output should be a form group containing a form group and fieldset' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        expect(fg).to have_tag('div', with: { class: 'govuk-fieldset' })
      end
    end

    context 'fieldset options' do
      context 'legend' do
        let(:text) { 'Pick your favourite colour' }

        context 'when supplied with custom text' do
          subject { builder.send(method, attribute, colours, :id, :name, legend: { text: text }) }

          specify 'should contain a fieldset header containing the supplied text' do
            expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
              expect(fg).to have_tag('div', with: { class: 'govuk-fieldset' }) do |fs|
                expect(fs).to have_tag('h1', text: text, with: { class: 'govuk-fieldset__heading' })
              end
            end
          end
        end

        context 'when no text is supplied' do
          subject { builder.send(method, attribute, colours, :id, :name, legend: { text: nil }) }

          specify 'output should not contain a header' do
            expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
              expect(fg).to have_tag('div', with: { class: 'govuk-fieldset' }) do |fs|
                expect(fs).not_to have_tag('h1')
              end
            end
          end
        end

        context 'when supplied with a custom tag' do
          let(:tag) { 'h4' }
          subject { builder.send(method, attribute, colours, :id, :name, legend: { text: text, tag: tag }) }

          specify 'output fieldset should contain the specified tag' do
            expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
              expect(fg).to have_tag('div', with: { class: 'govuk-fieldset' }) do |fs|
                expect(fs).to have_tag(tag, text: text)
              end
            end
          end
        end

        context 'when supplied with a custom size' do
          context 'with a valid size' do
            let(:size) { 'm' }
            subject { builder.send(method, attribute, colours, :id, :name, legend: { text: text, size: size }) }

            specify 'output fieldset should contain the specified tag' do
              expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
                expect(fg).to have_tag('div', with: { class: 'govuk-fieldset' }) do |fs|
                  expect(fs).to have_tag('h1', text: text, class: "govuk-fieldset__legend--#{size}")
                end
              end
            end
          end

          context 'with an invalid size' do
            let(:size) { 'miniscule' }
            subject { builder.send(method, attribute, colours, :id, :name, legend: { text: text, size: size }) }

            specify 'should raise an appropriate error' do
              expect { subject }.to raise_error(/invalid size #{size}/)
            end
          end
        end
      end
    end

    context 'when a hint is provided' do
      let(:hint) { 'The colour of your favourite handkerchief' }
      subject { builder.send(method, attribute, colours, :id, :name, hint: { text: hint }) }

      specify 'output should contain a hint' do
        expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
          expect(fg).to have_tag('span', text: hint, with: { class: 'govuk-hint' })
        end
      end

      specify 'output should also contain the fieldset' do
        expect(subject).to have_tag('div', with: { class: 'govuk-fieldset' })
      end

      specify 'the hint should be associated with the fieldset' do
        expect(parsed_subject.at_css('.govuk-fieldset')['aria-describedby'].split).to include(
          parsed_subject.at_css('.govuk-form-group > .govuk-hint')['id']
        )
      end
    end

    context 'when passed a block' do
      let(:block_h1) { 'The quick brown fox' }
      let(:block_h2) { 'Jumped over the' }
      let(:block_p) { 'Lazy dog.' }
      subject do
        builder.send(method, attribute, colours, :id, :name) do
          builder.safe_join([
            builder.tag.h1(block_h1),
            builder.tag.h2(block_h2),
            builder.tag.p(block_p)
          ])
        end
      end

      specify 'should include block content' do
        expect(subject).to have_tag('h1', text: block_h1)
        expect(subject).to have_tag('h2', text: block_h2)
        expect(subject).to have_tag('p', text: block_p)
      end
    end

    context 'radio buttons' do
      subject { builder.send(method, attribute, colours, :id, :name) }

      specify 'output should contain the correct number of radio buttons' do
        expect(subject).to have_tag('input', count: colours.size, with: { type: 'radio' })
        expect(subject).to have_tag('label', count: colours.size)
      end

      specify 'containing div should have attribute data-module="radios"' do
        expect(subject).to have_tag('div', with: { 'data-module' => 'radios' }) do |dm|
          expect(dm).to have_tag('input', count: colours.size, with: { type: 'radio' })
        end
      end

      specify 'radio buttons should be associated with corresponding labels' do
        colours.each do |colour|
          "person_favourite_colour_#{colour.id}".tap do |association|
            expect(subject).to have_tag('input', with: { id: association })
            expect(subject).to have_tag('label', with: { for: association })
          end
        end
      end

      specify 'radio buttons should have the correct id' do
        colours.each do |colour|
          "person_favourite_colour_#{colour.id}".tap do |association|
            expect(subject).to have_tag('input', with: { id: association })
          end
        end
      end

      specify 'radio buttons should have the correct id' do
        parsed_subject.css('input').each do |input|
          expect(input['name']).to eql('person[favourite_colour]')
        end
      end

      context 'when hint_method attribute is present' do
        let(:colours_with_descriptions) { colours.select { |c| c.description.present? } }
        let(:colours_without_descriptions) { colours.reject { |c| c.description.present? } }

        subject { builder.send(method, attribute, colours, :id, :name, :description) }

        specify 'the radio buttons with hints should contain hint text' do
          expect(subject).to have_tag('span', count: colours_with_descriptions.size, with: { class: 'govuk-hint govuk-radios__hint' })
        end

        specify 'the hint should be associated with the correct radio button' do
          colours_with_descriptions.each do |cwd|
            "person-favourite_colour-#{cwd.id}-hint".tap do |association|
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
    end

    context 'layout direction' do
      context 'when inline is specified in the options' do
        subject do
          builder.send(method, attribute, colours, :id, :name, :description, options: { inline: true })
        end

        specify "should have the additional class 'govuk-radios--inline'" do
          expect(subject).to have_tag('div', with: { class: %w(govuk-radios govuk-radios--inline) })
        end
      end

      context 'when inline is not specified in the options' do
        subject do
          builder.send(method, attribute, colours, :id, :name, :description, options: { inline: false })
        end

        specify "should not have the additional class 'govuk-radios--inline'" do
          expect(parsed_subject.at_css('.govuk-radios')['class']).to eql('govuk-radios')
        end
      end
    end
  end

  describe '#govuk_radio_buttons_fieldset' do
    let(:method) { :govuk_radio_buttons_fieldset }

    context 'when no block is supplied' do
      subject { builder.send(method, attribute) }
      specify { expect { subject }.to raise_error(LocalJumpError, /no block given/) }
    end

    context 'when a block is supplied' do
      let(:block_h1) { 'The quick brown fox' }
      let(:block_h2) { 'Jumped over the' }
      let(:block_p) { 'Lazy dog.' }

      subject do
        builder.send(method, attribute) do
          builder.safe_join([
            builder.tag.h1(block_h1),
            builder.tag.h2(block_h2),
            builder.tag.p(block_p)
          ])
        end
      end

      specify 'output should contain the contents of the block' do
        expect(subject).to have_tag('h1', text: block_h1)
        expect(subject).to have_tag('h2', text: block_h2)
        expect(subject).to have_tag('p', text: block_p)
      end
    end

    context 'when a block containing radio buttons is supplied' do
      subject do
        builder.send(method, attribute) do
          builder.safe_join([
            builder.govuk_radio_button(:favourite_colour, :red, label: { text: red_label }),
            builder.govuk_radio_button(:favourite_colour, :green, label: { text: green_label })
          ])
        end
      end

      specify 'output should be a form group containing a form group and fieldset' do
        expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
          expect(fg).to have_tag('div', with: { class: 'govuk-fieldset'})
        end
      end

      specify 'output should contain radio buttons' do
        expect(subject).to have_tag('div', with: { class: 'govuk-radios' }) do
        end
      end

      context 'layout direction' do
        context 'when inline is specified in the options' do
          subject do
            builder.send(method, attribute, options: { inline: true }) do
              builder.govuk_radio_button(:favourite_colour, :red, label: { text: red_label })
            end
          end

          specify "should have the additional class 'govuk-radios--inline'" do
            expect(subject).to have_tag('div', with: { class: %w(govuk-radios govuk-radios--inline) })
          end
        end

        context 'when inline is not specified in the options' do
          subject do
            builder.send(method, attribute, options: { inline: false }) do
              builder.govuk_radio_button(:favourite_colour, :red, label: { text: red_label })
            end
          end

          specify "should not have the additional class 'govuk-radios--inline'" do
            expect(parsed_subject.at_css('.govuk-radios')['class']).to eql('govuk-radios')
          end
        end
      end
    end
  end

  describe '#govuk_radio_button' do
    let(:method) { :govuk_radio_button }
    let(:value) { 'red' }

    subject { builder.send(method, attribute, value) }

    specify 'output should contain a radio item group with a radio input' do
      expect(subject).to have_tag('div', with: { class: 'govuk-radios__item' }) do |ri|
        expect(ri).to have_tag('input', with: { type: 'radio', value: value })
      end
    end

    context 'label' do
      context 'when a label is provided' do
        context 'with default options' do
          subject do
            builder.govuk_radio_button(:favourite_colour, :red, label: { text: red_label })
          end

          specify 'should contain a label with the correct text' do
            expect(subject).to have_tag('label', text: red_label)
          end
        end

        context 'with additional options' do
          subject do
            builder.govuk_radio_button(:favourite_colour, :red, label: { text: red_label, weight: 'bold', size: 'large' })
          end
          specify 'should allow label to be configured' do
            expect(subject).to have_tag('label', text: red_label, with: {
              class: 'govuk-label govuk-\!-font-size-48 govuk-\!-font-weight-bold'
            })
          end
        end
      end

      context 'when no label is provided' do
        subject do
          builder.govuk_radio_button(:favourite_colour, :red)
        end

        specify 'should contain a label with the correct text' do
          expect(subject).to have_tag('label', text: 'Favourite_colour')
        end
      end
    end

    context 'when a hint is provided' do
      subject do
        builder.govuk_radio_button(:favourite_colour, :red, hint: red_hint)
      end

      specify 'should contain a label with the correct text' do
        expect(subject).to have_tag('span', text: red_hint, with: { class: 'govuk-hint' })
      end
    end

    context 'conditionally revealing content' do
      context 'when a block is given' do
        subject do
          builder.govuk_radio_button(:favourite_colour, :red) do |rb|
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
          input_data_aria_controls = parsed_subject.at_css('input', type: 'radio')['data-aria-controls']
          conditional_id = parsed_subject.at_css('div.govuk-radios__conditional')['id']
          expect(input_data_aria_controls).to eql(conditional_id)
        end

        specify 'conditional_id contains the object, attribute and value name' do
          expect(
            parsed_subject.at_css('input', type: 'radio')['data-aria-controls']
          ).to eql('person-favourite_colour-red-conditional')
        end
      end

      context 'when no block is given' do
        subject { builder.govuk_radio_button(:favourite_colour, :red) }

        specify "the data-aria-controls attribute should be blank" do
          input_data_aria_controls = parsed_subject.at_css('input', type: 'radio')['data-aria-controls']
          expect(input_data_aria_controls).to be_nil
        end

        specify "the conditional container should not be present" do
          expect(subject).not_to have_tag('.govuk-radios__conditional')
        end
      end
    end
  end
end
