shared_examples 'a field that contains a customisable form group' do
  example_group 'when custom classes are provided' do
    let(:default_class) { %w(govuk-form-group) }
    let(:block_content) { %(Are you acquainted with our state's stringent usury laws?) }

    subject do
      builder.send(*args, form_group_classes: custom_classes) { builder.tag.span(block_content) }
    end

    context 'classes passed in as an array' do
      let(:custom_classes) { %w(red speckled) }

      specify 'the form group should contain the additional classes' do
        expect(subject).to have_tag('div', with: { class: default_class + custom_classes })
      end
    end

    context 'classes passed in as a string' do
      let(:custom_classes) { 'red speckled' }

      specify 'the form group should contain the additional classes' do
        expect(subject).to have_tag('div', with: { class: default_class + custom_classes.split })
      end
    end
  end
end
