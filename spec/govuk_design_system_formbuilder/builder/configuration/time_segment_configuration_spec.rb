describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  after { GOVUKDesignSystemFormBuilder.reset! }

  describe 'default time segments' do
    let(:overridden_segments) { { hour: 'c', minute: 'b', second: 'a' } }

    before do
      GOVUKDesignSystemFormBuilder.configure do |conf|
        conf.default_time_segments = overridden_segments
      end
    end

    subject { builder.govuk_time_field(:govuk_time_field) }

    specify 'uses the configured date segments' do
      overridden_segments.each do |segment, value|
        expect(subject).to have_tag("label", with: { for: "person_govuk_time_field_#{value}" }, text: segment.capitalize)
        expect(subject).to have_tag("input", with: { name: "person[govuk_time_field(#{value})]" })
      end
    end
  end

  describe 'default time segment names' do
    let(:overridden_segment_names) { { hour: "Hora", minute: "Minuto", second: "Segunda" } }

    before do
      GOVUKDesignSystemFormBuilder.configure do |conf|
        conf.default_time_segment_names = overridden_segment_names
      end
    end

    subject { builder.govuk_time_field(:govuk_time_field) }

    specify 'uses the configured time segment names for labels' do
      multiparamater_keys = { hour: '4i', minute: '5i', second: '6i' }

      overridden_segment_names.each do |segment, value|
        expect(subject).to have_tag("label", text: value, with: { for: "person_govuk_time_field_#{multiparamater_keys.fetch(segment)}" })
      end
    end
  end
end
