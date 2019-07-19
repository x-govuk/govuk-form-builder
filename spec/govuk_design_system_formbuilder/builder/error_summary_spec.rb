describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  let(:method) { :govuk_error_summary }

  describe '#govuk_error_summary' do
    subject { builder.send(method) }

    context 'when the object has errors' do
      before { object.valid? }

      specify 'the error summary should be present' do
        expect(subject).to have_tag('div', with: { class: 'govuk-error-summary' })
      end

      specify 'the error summary should have a title' do
        expect(subject).to have_tag(
          'h2',
          with: { id: 'error-summary-title', class: 'govuk-error-summary__title' }
        )
      end

      specify 'the error summary should have the correct accessibility attributes' do
        expect(subject).to have_tag(
          'div',
          with: {
            class: 'govuk-error-summary',
            tabindex: '-1',
            role: 'alert',
            'data-module' => 'error-summary'
          }
        )
      end

      specify 'the error summary should contain a list with all the errors included' do
        expect(subject).to have_tag('ul', with: { class: %w(govuk-list govuk-error-summary__list) }) do
          expect(subject).to have_tag('li', count: object.errors.count)
        end
      end

      context 'error messages' do
        subject! { builder.send(method) }

        specify 'the error message list should contain the correct messages' do
          object.errors.messages.each do |_attribute, msg|
            expect(subject).to have_tag('li', text: msg.join) do
            end
          end
        end

        specify 'the error message list should contain links to relevant errors' do
          object.errors.messages.each do |attribute, _msg|
            expect(subject).to have_tag('a', with: {
              href: "#person-#{underscores_to_dashes(attribute)}-field-error",
              'data-turbolinks' => false
            })
          end
        end

        def underscores_to_dashes(val)
          val.to_s.tr('_', '-')
        end
      end
    end

    context 'when the object has no errors' do
      let(:object) { Person.valid_example }
      subject { builder.send(method) }

      specify 'no error summary should be present' do
        expect(subject).to be_nil
      end
    end
  end
end
