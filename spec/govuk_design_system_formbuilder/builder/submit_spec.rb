describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe '#submit' do
    let(:method) { :govuk_submit }
    let(:text) { 'Create' }
    let(:args) { [method] }
    subject { builder.send(method, text) }

    specify 'output should be a submit input' do
      expect(subject).to have_tag('input', with: { type: 'submit' })
    end

    specify 'button should have the correct classes' do
      expect(subject).to have_tag('input', with: { class: 'govuk-button' })
    end

    specify 'button should have the correct text' do
      expect(subject).to have_tag('input', with: { value: text })
    end

    specify 'button should have the govuk-button data-module' do
      expect(subject).to have_tag('input', with: { 'data-module' => 'govuk-button' })
    end

    context 'when no value is passed in' do
      subject { builder.send(method) }

      specify %(it should default to 'Continue) do
        expect(subject).to have_tag('input', with: { value: 'Continue' })
      end
    end

    describe 'button styles and colours' do
      context 'warning' do
        subject { builder.send(*args.push('Create'), warning: true) }

        specify 'button should have the warning class' do
          expect(subject).to have_tag('input', with: { class: %w(govuk-button govuk-button--warning) })
        end
      end

      context 'secondary' do
        subject { builder.send(*args.push('Create'), secondary: true) }

        specify 'button should have the secondary class' do
          expect(subject).to have_tag('input', with: { class: %w(govuk-button govuk-button--secondary) })
        end
      end

      context 'warning and secondary' do
        subject { builder.send(*args.push('Create'), secondary: true, warning: true) }

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
        subject { builder.send(*args.push(text), prevent_double_click: false) }

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
        subject { builder.send(*args) }

        specify 'should have attribute formnovalidate' do
          expect(subject).to have_tag('input', with: { type: 'submit', formnovalidate: 'formnovalidate' })
        end
      end

      context 'when validate is false' do
        subject { builder.send(*args, validate: false) }

        specify 'should have attribute formnovalidate' do
          expect(subject).to have_tag('input', with: { type: 'submit', formnovalidate: 'formnovalidate' })
        end
      end

      context 'when validate is true' do
        subject { builder.send(*args, validate: true) }

        specify 'should have attribute formnovalidate' do
          expect(parsed_subject.at_css('input').attributes.keys).not_to include('formnovalidate')
        end
      end
    end
  end
end
