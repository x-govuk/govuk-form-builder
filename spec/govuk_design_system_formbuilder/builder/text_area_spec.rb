describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  let(:method) { :govuk_text_area }
  let(:attribute) { :cv }
  let(:label_text) { 'A brief list of your achievements' }
  let(:hint_text) { 'Keep it to a page, nobody will read it anyway' }
  let(:args) { [method, attribute] }
  let(:field_type) { 'textarea' }
  subject { builder.send(*args) }

  shared_context 'a text area that is associated with a character count description' do
    context 'association with the text area' do
      context 'when there are no errors on the field' do
        specify "should have a id that matches the text area with additional suffix '-info'" do
          text_area_id = parsed_subject.at_css('textarea')['id']

          expect(subject).to have_tag('span', with: { id: text_area_id + "-info" })
        end
      end

      context 'when there are errors on the field' do
        before { object.valid? }
        specify "should have a id that matches the text area with additional suffix '-info'" do
          text_area_id = parsed_subject.at_css('textarea')['id']
          expect(text_area_id).to end_with('-error')
          expect(subject).to have_tag('span', with: { id: text_area_id + '-info' })
        end
      end
    end
  end

  specify 'should output a form group containing a textarea' do
    expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
      expect(fg).to have_tag('textarea')
    end
  end

  include_examples 'HTML formatting checks'

  it_behaves_like 'a field that accepts arbitrary blocks of HTML' do
    let(:described_element) { 'textarea' }
  end

  it_behaves_like 'a field that supports labels', 'textarea'
  it_behaves_like 'a field that supports captions on the label'
  it_behaves_like 'a field that supports labels as procs'
  it_behaves_like 'a field that contains a customisable form group'

  it_behaves_like 'a field that supports hints' do
    let(:aria_described_by_target) { 'textarea' }
  end

  it_behaves_like 'a field that supports custom branding'

  it_behaves_like 'a field that supports errors' do
    let(:object) { Person.new(cv: 'a' * 50) } # max length is 30
    let(:aria_described_by_target) { 'textarea' }

    let(:error_message) { /too long/ }
    let(:error_class) { 'govuk-textarea--error' }
    let(:error_identifier) { 'person-cv-error' }
  end

  it_behaves_like 'a field that supports setting the label via localisation'
  it_behaves_like 'a field that supports setting the label caption via localisation'
  it_behaves_like 'a field that supports setting the hint via localisation'

  it_behaves_like 'a field that allows extra HTML attributes to be set' do
    let(:described_element) { 'textarea' }
    let(:expected_class) { 'govuk-textarea' }
  end

  it_behaves_like 'a field that allows nested HTML attributes to be set' do
    let(:described_element) { 'textarea' }
    let(:expected_class) { 'govuk-textarea' }
  end

  it_behaves_like 'a field that accepts a plain ruby object' do
    let(:described_element) { 'textarea' }
  end

  specify 'should have the correct classes' do
    expect(subject).to have_tag('textarea', with: { class: 'govuk-textarea' })
  end

  specify 'should be no character count description when no limit is specified' do
    expect(subject).not_to have_tag('span', with: { class: 'govuk-character-count__message' })
  end

  describe 'limits' do
    context 'max words' do
      let(:max_words) { 20 }
      subject { builder.send(*args, max_words: max_words) }

      specify 'should wrap the form group inside a character count tag' do
        expect(subject).to have_tag(
          'div',
          with: {
            class: 'govuk-character-count',
            'data-module' => 'govuk-character-count',
            'data-maxwords' => max_words
          }
        )
      end

      specify 'should add govuk-js-character-count class to the textarea' do
        expect(subject).to have_tag('textarea', with: { class: 'govuk-js-character-count' })
      end

      context 'limit description' do
        let(:message_selector) { { with: { class: 'govuk-character-count__message' } } }

        specify 'should add a character count description' do
          expect(subject).to have_tag('span', **message_selector)
        end

        specify 'the description should contain the correct limit and count type' do
          expect(subject).to have_tag('span', **message_selector, text: /#{max_words} words/)
        end

        it_behaves_like 'a text area that is associated with a character count description'
      end
    end

    context 'max chars' do
      let(:max_chars) { 35 }
      subject { builder.send(*args, max_chars: max_chars) }

      specify 'should wrap the form group inside a character count tag' do
        expect(subject).to have_tag(
          'div',
          with: {
            class: 'govuk-character-count',
            'data-module' => 'govuk-character-count',
            'data-maxlength' => max_chars
          }
        )
      end

      specify 'should add govuk-js-character-count class to the textarea' do
        expect(subject).to have_tag('textarea', with: { class: 'govuk-js-character-count' })
      end

      context 'limit description' do
        let(:message_selector) { { with: { class: 'govuk-character-count__message' } } }

        specify 'should add a character count description' do
          expect(subject).to have_tag('span', **message_selector)
        end

        specify 'the description should contain the correct limit and count type' do
          expect(subject).to have_tag('span', **message_selector, text: /#{max_chars} characters/)
        end

        it_behaves_like 'a text area that is associated with a character count description'
      end
    end

    context 'max chars and max words' do
      subject { builder.send(*args, max_chars: 5, max_words: 5) }

      specify 'should raise an error' do
        expect { subject }.to raise_error(ArgumentError, 'limit can be words or chars')
      end
    end

    context 'thresholds' do
      let(:threshold) { 60 }
      let(:max_chars) { 35 }
      subject { builder.send(*args, max_chars: max_chars, threshold: threshold) }

      specify 'should wrap the form group inside a character count tag with a threshold' do
        expect(subject).to have_tag(
          'div',
          with: {
            class: 'govuk-character-count',
            'data-module' => 'govuk-character-count',
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
end
