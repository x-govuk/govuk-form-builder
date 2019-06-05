describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe '#govuk_collection_select' do
    let(:attribute) { :favourite_colour }
    let(:label_text) { 'Cherished shade' }
    let(:method) { :govuk_collection_radio_buttons }
    let(:colours) do
      [
        OpenStruct.new(id: 'red', name: 'Red', description: 'Roses are red'),
        OpenStruct.new(id: 'blue', name: 'Blue', description: 'Violets are... purple?'),
        OpenStruct.new(id: 'green', name: 'Green'),
        OpenStruct.new(id: 'yellow', name: 'Yellow')
      ]
    end

    subject { builder.send(method, attribute, colours, :id, :name) }

    specify 'output should be a form group containing a form group and fieldset' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        expect(fg).to have_tag('div.govuk-fieldset')
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

      specify 'the hint should be associated with the fieldset'
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

      specify 'containing div should have attribute data-module="radios"'

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
  end
end
