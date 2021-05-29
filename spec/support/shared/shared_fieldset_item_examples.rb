shared_examples 'a fieldset item that can conditionally-reveal content' do
  context 'when a block is given' do
    specify 'should place the conditional content at the same level as the container' do
      expect(parsed_subject).to have_root_element_with_class("govuk-#{fieldset_item_type}__conditional")
    end

    specify 'should include content provided in the block in a conditional div' do
      expected_classes = ["govuk-#{fieldset_item_type}__conditional", "govuk-#{fieldset_item_type}__conditional--hidden"]

      expect(subject).to have_tag('div', with: { class: expected_classes }) do
        with_tag('label', with: { class: 'govuk-label' }, text: 'Stationery_choice')
        with_tag('input', with: { type: 'text' })
      end
    end

    specify "the data-aria-controls attribute should match the conditional block's id" do
      expected_id = [object_name, attribute, value_with_dashes, 'conditional'].join("-")

      expect(subject).to have_tag('input', with: { type: fieldset_item_type_single, 'data-aria-controls' => expected_id })
      expect(subject).to have_tag('div', { id: expected_id })
    end
  end

  context 'when an empty block is given' do
    subject { builder.send(*args) { "" } }

    specify "the data-aria-controls attribute should not be present" do
      input_data_aria_controls = parsed_subject.at_css("input[type='#{fieldset_item_type_single}']")['data-aria-controls']
      expect(input_data_aria_controls).to be_nil
    end

    specify "the conditional container should not be present" do
      expect(subject).not_to have_tag(".govuk-#{fieldset_item_type}__conditional")
    end
  end

  context 'when no block is given' do
    subject { builder.send(*args) }

    specify "the data-aria-controls attribute should not be present" do
      input_data_aria_controls = parsed_subject.at_css("input[type='#{fieldset_item_type_single}']")['data-aria-controls']
      expect(input_data_aria_controls).to be_nil
    end

    specify "the conditional container should not be present" do
      expect(subject).not_to have_tag(".govuk-#{fieldset_item_type}__conditional")
    end
  end
end
