describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe '#govuk_collection_select' do
    let(:attribute) { :favourite_colour }
    let(:label_text) { 'Cherished shade' }
    let(:method) { :govuk_collection_radio_buttons }
    let(:colours) do
      [
        OpenStruct.new(id: 'red', name: 'Red'),
        OpenStruct.new(id: 'blue', name: 'Blue'),
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
  end
end
