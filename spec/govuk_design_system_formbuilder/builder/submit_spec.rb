describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe '#submit' do
    let(:method) { :govuk_submit }
    let(:text) { 'Create' }
    subject { builder.send(method, text) }

    specify 'output should be a form group containing a submit input' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        expect(fg).to have_tag('input', with: { type: 'submit' })
      end
    end

    specify 'button should have the correct classes' do
      expect(subject).to have_tag('input', with: { class: 'govuk-button' })
    end

    specify 'button should have the correct text' do
      expect(subject).to have_tag('input', with: { value: text })
    end

    describe 'button styles and colours' do
      context 'warning' do
        subject { builder.send(method, 'Create', warning: true) }

        specify 'button should have the warning class' do
          expect(subject).to have_tag('input', with: { class: %w(govuk-button govuk-button--warning) })
        end
      end

      context 'secondary' do
        subject { builder.send(method, 'Create', secondary: true) }

        specify 'button should have the secondary class' do
          expect(subject).to have_tag('input', with: { class: %w(govuk-button govuk-button--secondary) })
        end
      end

      context 'warning and secondary' do
        subject { builder.send(method, 'Create', secondary: true, warning: true) }

        specify 'should fail' do
          expect { subject }.to raise_error(ArgumentError, /buttons can be warning or secondary/)
        end
      end
    end

    describe 'preventing double clicks' do
      specify 'data attribute should be present by default' do
        expect(subject).to have_tag('input', with: { 'data-prevent-double-click' => true })
      end

      context 'when disabled' do
        subject { builder.send(method, text, prevent_double_click: false) }

        specify 'data attribute should not be present by default' do
          expect(
            parsed_subject.at_css('input').attributes.keys
          ).not_to include('data-prevent-double-click')
        end
      end
    end

    describe 'extra buttons passed in via a block' do
      let(:target) { '#' }
      let(:classes) { %w(govuk-button govuk-button--secondary) }
      subject do
        builder.send(method) do
          builder.link_to('Cancel', target, class: classes)
        end
      end

      specify 'should display the extra content' do
        expect(subject).to have_tag('a', with: { href: target, class: classes })
      end

      specify 'should add an extra margin class to the submit' do
        expect(subject).to have_tag('input', with: { class: 'govuk-\!-margin-right-1' })
      end
    end

    describe 'preventing client-side validation' do
      context 'should be novalidate by default' do
        subject { builder.send(method) }

        specify 'should have attribute formnovalidate' do
          expect(subject).to have_tag('input', with: { type: 'submit', formnovalidate: 'formnovalidate' })
        end
      end

      context 'when validate is false' do
        subject { builder.send(method, validate: false) }

        specify 'should have attribute formnovalidate' do
          expect(subject).to have_tag('input', with: { type: 'submit', formnovalidate: 'formnovalidate' })
        end
      end

      context 'when validate is true' do
        subject { builder.send(method, validate: true) }

        specify 'should have attribute formnovalidate' do
          expect(parsed_subject.at_css('input').attributes.keys).not_to include('formnovalidate')
        end
      end
    end
  end
end
