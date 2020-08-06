shared_examples 'a field that contains a customisable form group' do
  let(:block_content) { %(Are you acquainted with our state's stringent usury laws?) }

  example_group 'when custom classes are provided' do
    let(:default_class) { %w(govuk-form-group) }

    subject do
      builder.send(*args, form_group: { classes: custom_classes }) { builder.tag.span(block_content) }
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

  example_group 'when a custom id is provided' do
    let(:custom_id) { %(xyz-123) }

    subject do
      builder.send(*args, form_group: { id: custom_id }) { builder.tag.span(block_content) }
    end

    specify 'the form group should contain the additional classes' do
      expect(subject).to have_tag('div', with: { id: custom_id })
    end
  end
end
