describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  after { GOVUKDesignSystemFormBuilder.reset! }

  describe 'legend config' do
    include_context 'setup radios'
    let(:method) { :govuk_collection_radio_buttons }
    let(:colours) { Array.wrap(OpenStruct.new(id: 'red', name: 'Red')) }
    let(:args) { [method, attribute, colours, :id, :name] }
    let(:legend_text) { 'Choose a colour' }

    subject { builder.send(*args, legend: { text: legend_text }) }

    describe 'legend tag' do
      specify 'the default tag should be nil' do
        expect(GOVUKDesignSystemFormBuilder.config.default_legend_tag).to be_nil
      end

      context 'overriding with h6' do
        let(:configured_tag) { 'h6' }

        before do
          GOVUKDesignSystemFormBuilder.configure do |conf|
            conf.default_legend_tag = configured_tag
          end
        end

        specify 'should create a legend header wrapped in a h6 tag' do
          expect(subject).to have_tag(
            configured_tag,
            with: {
              class: 'govuk-fieldset__heading'
            },
            text: legend_text,
          )
        end
      end
    end

    describe 'legend size' do
      specify 'the default size should be m' do
        expect(GOVUKDesignSystemFormBuilder.config.default_legend_size).to eql('m')
      end

      context 'overriding with s' do
        let(:configured_size) { 's' }

        before do
          GOVUKDesignSystemFormBuilder.configure do |conf|
            conf.default_legend_size = configured_size
          end
        end

        specify 'should create a legend header with the small class' do
          expect(subject).to have_tag('fieldset') do
            with_tag('legend', with: { class: "govuk-fieldset__legend--#{configured_size}" })
          end
        end
      end
    end
  end
end
