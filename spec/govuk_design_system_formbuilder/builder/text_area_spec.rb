describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  let(:method) { :govuk_text_area }
  let(:attribute) { :cv }
  let(:label_text) { 'A brief list of your achievements' }
  let(:hint_text) { 'Keep it to a page, nobody will read it anyway' }

  subject { builder.send(method, attribute) }

  specify 'should output a form group containing a textarea' do
    expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
      expect(fg).to have_tag('textarea')
    end
  end

  specify 'should have the correct classes' do
    expect(subject).to have_tag('textarea', with: { class: 'govuk-textarea' })
  end

  describe 'errors' do
    context 'when the attribute has errors' do
      let(:object) { Person.new(cv: 'a' * 50) } # max length is 30
      before { object.valid? }

      specify 'an error message should be displayed' do
        expect(subject).to have_tag('span', with: { class: 'govuk-error-message' }, text: /too long/)
      end

      specify 'the textarea element should have the correct error classes' do
        expect(subject).to have_tag('textarea', with: { class: 'govuk-textarea--error' })
      end
    end

    context 'when the attribute has no errors' do
      specify 'no error messages should be displayed' do
        expect(subject).not_to have_tag('span', with: { class: 'govuk-error-message' })
      end
    end
  end

  describe 'label' do
    context 'when a label is provided' do
      subject { builder.send(method, attribute, label: { text: label_text }) }

      specify 'the label should be included' do
        expect(subject).to have_tag('label', with: { class: 'govuk-label' }, text: label_text)
      end
    end

    context 'when no label is provided' do
      specify 'the label should have the default value' do
        expect(subject).to have_tag('label', with: { class: 'govuk-label' }, text: attribute.capitalize)
      end
    end
  end

  describe 'hint' do
    context 'when a hint is provided' do
      subject { builder.send(method, attribute, hint_text: hint_text) }

      specify 'the hint should be included' do
        expect(subject).to have_tag('span', with: { class: 'govuk-hint' }, text: hint_text)
      end
    end

    context 'when no hint is provided' do
      specify 'no hint should be included' do
        expect(subject).not_to have_tag('span', with: { class: 'govuk-hint' })
      end
    end
  end

  describe 'limits' do
    context 'max words' do
      let(:max_words) { 20 }
      subject { builder.send(method, attribute, max_words: max_words) }

      specify 'should wrap the form group inside a character count tag' do
        expect(subject).to have_tag(
          'div',
          with: {
            class: 'govuk-character-count',
            'data-module' => 'character-count',
            'data-maxwords' => max_words
          }
        )
      end

      specify 'should add js-character-count class to the textarea' do
        expect(subject).to have_tag('textarea', with: { class: 'js-character-count' })
      end

      specify 'should add a character count message' do
        expect(subject).to have_tag(
          'span',
          with: { class: 'govuk-character-count__message' },
          text: "You can enter up to #{max_words} words"
        )
      end
    end

    context 'max chars' do
      let(:max_chars) { 35 }
      subject { builder.send(method, attribute, max_chars: max_chars) }

      specify 'should wrap the form group inside a character count tag' do
        expect(subject).to have_tag(
          'div',
          with: {
            class: 'govuk-character-count',
            'data-module' => 'character-count',
            'data-maxlength' => max_chars
          }
        )
      end

      specify 'should add js-character-count class to the textarea' do
        expect(subject).to have_tag('textarea', with: { class: 'js-character-count' })
      end

      specify 'should add a character count message' do
        expect(subject).to have_tag(
          'span',
          with: { class: 'govuk-character-count__message' },
          text: "You can enter up to #{max_chars} characters"
        )
      end
    end

    context 'max chars and max words' do
      subject { builder.send(method, attribute, max_chars: 5, max_words: 5) }

      specify 'should raise an error' do
        expect { subject }.to raise_error(ArgumentError, 'limit can be words or chars')
      end
    end

    context 'thresholds' do
      let(:threshold) { 60 }
      let(:max_chars) { 35 }
      subject { builder.send(method, attribute, max_chars: max_chars, threshold: threshold) }

      specify 'should wrap the form group inside a character count tag with a threshold' do
        expect(subject).to have_tag(
          'div',
          with: {
            class: 'govuk-character-count',
            'data-module' => 'character-count',
            'data-maxlength' => max_chars,
            'data-threshold' => threshold
          }
        )
      end
    end
  end

  context 'rows' do
    context 'defaults' do
      specify 'should default to 5' do
        expect(subject).to have_tag('textarea', with: { rows: 5 })
      end
    end

    context 'overriding' do
      let(:rows) { 8 }
      subject { builder.send(method, attribute, rows: rows) }

      specify 'should have the overriden number of rows' do
        expect(subject).to have_tag('textarea', with: { rows: rows })
      end
    end
  end

  describe 'extra arguments' do
    let(:placeholder) { 'Once upon a time…' }
    subject { builder.send(method, attribute, placeholder: placeholder, required: true) }

    specify 'should add the extra attributes to the textarea' do
      expect(subject).to have_tag(
        'textarea',
        with: {
          placeholder: placeholder,
          required: 'required'
        }
      )
    end
  end
end
