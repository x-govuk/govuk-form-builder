describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  describe 'labels auto bolding config' do
    specify %(the default should be to bold labels when hints are present) do
      expect(GOVUKDesignSystemFormBuilder.config.default_collection_radio_buttons_auto_bold_labels).to be(true)
    end

    let(:label_selector) { 'label.govuk-label' }
    let(:bold_label_selector) { label_selector + '--s' }
    let(:method) { :govuk_collection_radio_buttons }
    let(:attribute) { :favourite_shape }

    let(:shapes) do
      [
        OpenStruct.new(id: 't', name: 'Triangle', description: 'A three-edged polygon'),
        OpenStruct.new(id: 's', name: 'Square', description: 'A regular quadrilateral'),
        OpenStruct.new(id: 'p', name: 'Pentagon'),
        OpenStruct.new(id: 'h', name: 'Hexagon'),
      ]
    end

    let(:args) { [method, attribute, shapes, :id, :name, :description] }
    let(:kwargs) { {} }

    subject { builder.send(*args, **kwargs) }

    context 'when default_collection_radio_buttons_auto_bold_labels is set to true' do
      specify 'all of the labels are bold' do
        expect(subject).to have_tag(label_selector, count: shapes.size)
        expect(subject).to have_tag(bold_label_selector, count: shapes.size)
      end

      context %(when the default is overriden with the 'bold_labels' argument) do
        let(:kwargs) { { bold_labels: false } }

        specify 'none of the labels are bold' do
          expect(subject).to have_tag(label_selector, count: shapes.size)
          expect(subject).not_to have_tag(bold_label_selector)
        end
      end
    end

    context 'when default_collection_radio_buttons_auto_bold_labels is set to false' do
      before do
        GOVUKDesignSystemFormBuilder.configure do |conf|
          conf.default_collection_radio_buttons_auto_bold_labels = false
        end
      end

      after { GOVUKDesignSystemFormBuilder.reset! }

      specify 'none of the labels are bold' do
        expect(subject).to have_tag(label_selector, count: shapes.size)
        expect(subject).not_to have_tag(bold_label_selector)
      end

      context %(when the default is overriden with the 'bold_labels' argument) do
        let(:kwargs) { { bold_labels: true } }

        specify 'all of the labels are bold' do
          expect(subject).to have_tag(label_selector, count: shapes.size)
          expect(subject).to have_tag(bold_label_selector, count: shapes.size)
        end
      end
    end
  end
end
