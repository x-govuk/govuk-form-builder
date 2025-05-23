describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  after { GOVUKDesignSystemFormBuilder.reset! }

  describe 'default date segments' do
    let(:overridden_segments) { { day: 'c', month: 'b', year: 'a' } }

    before do
      GOVUKDesignSystemFormBuilder.configure do |conf|
        conf.default_date_segments = overridden_segments
      end
    end

    subject { builder.govuk_date_field(:govuk_date_field) }

    specify 'uses the configured date segments' do
      overridden_segments.each do |segment, value|
        expect(subject).to have_tag("label", with: { for: "person_govuk_date_field_#{value}" }, text: segment.capitalize)
        expect(subject).to have_tag("input", with: { name: "person[govuk_date_field(#{value})]" })
      end
    end
  end

  describe 'default date segment names' do
    let(:overridden_segment_names) { { day: "Jour", month: "Mois", year: "Annee" } }

    before do
      GOVUKDesignSystemFormBuilder.configure do |conf|
        conf.default_date_segment_names = overridden_segment_names
      end
    end

    subject { builder.govuk_date_field(:govuk_date_field) }

    specify 'uses the configured date segment names for labels' do
      multiparamater_keys = { day: '3i', month: '2i', year: '1i' }

      overridden_segment_names.each do |segment, value|
        expect(subject).to have_tag("label", text: value, with: { for: "person_govuk_date_field_#{multiparamater_keys.fetch(segment)}" })
      end
    end
  end
end
