describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe 'Button' do
    # we only generate `<input type=submit...` so ignore everything else like `<button>`
    applicable = ['input']
    
    fixtures = JSON
      .parse(File.read('guide/node_modules/govuk-frontend/govuk/components/button/fixtures.json'))
      .select { |f| f['name'].in?(applicable) }

    fixtures.each do |fixture|
      describe fixture['name'] do
        let(:expected) { fixture['html'] }

        let(:button_text) { fixture.dig('options', 'text') }
        subject { builder.govuk_submit(button_text) }

        # name: input
        # options:
        #   element: input
        #   name: start-now
        #   text: Start now
        #   html: <input value="Start now" type="submit" name="start-now" class="govuk-button" data-module="govuk-button">

        specify 'should match the HTML' do
          expect(subject).to eql(expected)
        end
      end
    end
  end
end
