describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe '#submit' do
    let(:method) { :govuk_submit }
    let(:text) { 'Create' }
    let(:args) { [method] }
    subject { builder.send(method, text) }

    include_examples 'HTML formatting checks'

    it_behaves_like 'a field that supports custom branding'

    it_behaves_like 'a field that supports custom classes' do
      let(:element) { 'button' }
      let(:default_classes) { %w(govuk-button) }
      let(:block_content) { -> { %(Example) } }
    end

    it_behaves_like 'a field that allows extra HTML attributes to be set' do
      let(:described_element) { 'button' }
      let(:expected_class) { 'govuk-button' }
    end

    specify 'output should be a button element' do
      expect(subject).to have_tag('button', with: { type: 'submit' })
    end

    specify 'button should have the correct classes' do
      expect(subject).to have_tag('button', with: { class: 'govuk-button' })
    end

    specify 'button should have the correct text' do
      expect(subject).to have_tag('button', text: text)
    end

    specify 'button should have the govuk-button data-module' do
      expect(subject).to have_tag('button', with: { 'data-module' => 'govuk-button' })
    end

    context 'when no value is passed in' do
      subject { builder.send(method) }

      specify %(it should default to 'Continue) do
        expect(subject).to have_tag('button', text: 'Continue')
      end
    end

    describe 'button styles and colours' do
      context 'warning' do
        subject { builder.send(*args.push('Create'), warning: true) }

        specify 'button should have the warning class' do
          expect(subject).to have_tag('button', with: { class: %w(govuk-button govuk-button--warning) })
        end
      end

      context 'secondary' do
        subject { builder.send(*args.push('Create'), secondary: true) }

        specify 'button should have the secondary class' do
          expect(subject).to have_tag('button', with: { class: %w(govuk-button govuk-button--secondary) })
        end
      end

      context 'warning and secondary' do
        subject { builder.send(*args.push('Create'), secondary: true, warning: true) }

        specify 'should fail' do
          expect { subject }.to raise_error(ArgumentError, /buttons can be warning or secondary/)
        end
      end

      context 'classes' do
        subject { builder.send(*args.push('Create'), class: %w(custom-class--one custom-class--two)) }

        specify 'button should have the custom class' do
          expect(subject).to have_tag('button', with: { class: %w(govuk-button custom-class--one custom-class--two) })
        end
      end
    end

    describe 'preventing double clicks' do
      specify 'data attribute should be present by default' do
        expect(subject).to have_tag('button', with: { 'data-prevent-double-click' => true })
      end

      context 'when disabled' do
        subject { builder.send(*args.push(text), prevent_double_click: false) }

        specify 'data attribute should not be present by default' do
          expect(
            parsed_subject.at_css('button').attributes.keys
          ).not_to include('data-prevent-double-click')
        end
      end
    end

    describe 'extra buttons passed in via a block' do
      let(:text) { 'Cancel' }
      let(:target) { '/some-amazing-page' }
      let(:classes) { %w(govuk-button govuk-button--secondary) }
      subject do
        builder.send(method) do
          builder.link_to(text, target, class: classes)
        end
      end

      specify 'should display the extra content' do
        expect(subject).to have_tag('a', with: { href: target, class: classes })
      end

      specify 'should wrap the buttons and extra content in a button group' do
        expect(subject).to have_tag('div', with: { class: 'govuk-button-group' }) do
          with_tag('button', text: 'Continue')
          with_tag('a', text: text, with: { href: target })
        end
      end
    end

    describe 'preventing client-side validation' do
      context 'should be novalidate by default' do
        subject { builder.send(*args) }

        specify 'should have attribute formnovalidate' do
          expect(subject).to have_tag('button', with: { type: 'submit', formnovalidate: 'formnovalidate' })
        end
      end

      context 'when validate is false' do
        subject { builder.send(*args, validate: false) }

        specify 'should have attribute formnovalidate' do
          expect(subject).to have_tag('button', with: { type: 'submit', formnovalidate: 'formnovalidate' })
        end
      end

      context 'when validate is true' do
        subject { builder.send(*args, validate: true) }

        specify 'should have attribute formnovalidate' do
          expect(parsed_subject.at_css('button').attributes.keys).not_to include('formnovalidate')
        end
      end
    end

    describe 'disabling button' do
      context 'when disabled is false' do
        subject { builder.send(*args.push('Create')) }

        specify 'button should not have the disabled attribute' do
          expect(parsed_subject.at_css('button').attributes.keys).not_to include('disabled')
        end
      end

      context 'when disabled is true' do
        subject { builder.send(*args.push('Create'), disabled: true) }

        specify 'button should have the disabled attribute' do
          expect(parsed_subject.at_css('button').attributes.keys).to include('disabled')
          expect(subject).to have_tag('button', with: { class: %w(govuk-button govuk-button--disabled) })
        end
      end
    end

    describe 'setting the button content with a proc' do
      let(:custom_text) { "Click me!" }
      let(:custom_wrapper) { :strong }
      let(:custom_content) { -> { builder.content_tag(custom_wrapper, custom_text) } }

      subject { builder.send(*args, custom_content) }

      specify "renders the custom content inside the button element" do
        expect(subject).to have_tag("button") do
          with_tag(custom_wrapper, text: custom_text)
        end
      end

      context "when the button content is invalid" do
        subject { builder.send(*args, Date.today) }

        specify "fails with an appropriate error message" do
          expect { subject }.to raise_error(ArgumentError, /text must be a String or Proc/)
        end
      end
    end
  end
end
