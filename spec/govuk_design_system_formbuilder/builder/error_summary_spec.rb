describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  let(:method) { :govuk_error_summary }

  describe '#govuk_error_summary' do
    let(:args) { [method] }
    subject { builder.send(*args) }

    context 'when the object has errors' do
      before { object.valid? }

      include_examples 'HTML formatting checks'

      specify 'the error summary should be present' do
        expect(subject).to have_tag('div', with: { class: 'govuk-error-summary' })
      end

      specify 'the error summary should have a title' do
        expect(subject).to have_tag(
          'h2',
          with: { id: 'error-summary-title', class: 'govuk-error-summary__title' }
        )
      end

      specify 'the error summary should have the correct accessibility attributes' do
        expect(subject).to have_tag(
          'div',
          with: {
            class: 'govuk-error-summary',
            tabindex: '-1',
            role: 'alert',
            'data-module' => 'govuk-error-summary'
          }
        )
      end

      describe 'error messages' do
        let(:kwargs) { {} }
        subject! { builder.send(*args, **kwargs) }

        context 'when there are multiple errors each with one error message' do
          let(:object) { Person.new(favourite_colour: nil, projects: []) }

          specify 'the error summary should contain a list with one error message per field' do
            expect(subject).to have_tag('ul', with: { class: %w(govuk-list govuk-error-summary__list) }) do
              expect(subject).to have_tag('li', text: 'Choose a favourite colour')
              expect(subject).to have_tag('li', text: 'Select at least one project')
            end
          end
        end

        context 'when there are multiple errors and one has multiple error messages' do
          let(:object) { Person.new(name: nil, favourite_colour: nil) }

          specify 'the error summary should contain a list with one error message per field' do
            expect(subject).to have_tag('ul', with: { class: %w(govuk-list govuk-error-summary__list) }) do
              expect(subject).to have_tag('li', text: 'Choose a favourite colour')
              expect(subject).to have_tag('li', text: 'Enter a name')
            end
          end
        end

        specify 'the error message list should contain the correct messages' do
          object.errors.messages.each do |_attribute, message_list|
            expect(subject).to have_tag('li', text: message_list.first) do
            end
          end
        end

        specify 'the error message list should contain links to relevant errors' do
          object.errors.messages.each do |attribute, _msg|
            expect(subject).to have_tag('a', with: {
              href: "#person-#{underscores_to_dashes(attribute)}-field-error",
              'data-turbolinks' => false
            })
          end
        end

        describe 'linking to elements' do
          it_behaves_like 'an error summary linking directly to a form element', :govuk_text_field
          it_behaves_like 'an error summary linking directly to a form element', :govuk_number_field
          it_behaves_like 'an error summary linking directly to a form element', :govuk_phone_field
          it_behaves_like 'an error summary linking directly to a form element', :govuk_url_field
          it_behaves_like 'an error summary linking directly to a form element', :govuk_email_field
          it_behaves_like 'an error summary linking directly to a form element', :govuk_password_field
          it_behaves_like 'an error summary linking directly to a form element', :govuk_file_field
          it_behaves_like 'an error summary linking directly to a form element', :govuk_text_area, 'textarea'

          describe 'collection select boxes' do
            let(:object) { Person.new(favourite_colour: nil) }
            let(:identifier) { 'person-favourite-colour-field-error' }
            subject do
              builder.safe_join(
                [
                  builder.govuk_error_summary,
                  builder.govuk_collection_select(:favourite_colour, colours, :id, :name)
                ]
              )
            end

            specify "the error message should link directly to the govuk_collection_select field" do
              expect(subject).to have_tag('a', with: { href: "#" + identifier })
              expect(subject).to have_tag('select', with: { id: identifier })
            end
          end

          describe 'radio button collections' do
            let(:object) { Person.new(favourite_colour: nil) }
            let(:identifier) { 'person-favourite-colour-field-error' }
            subject do
              builder.content_tag('div') do
                builder.safe_join(
                  [
                    builder.govuk_error_summary,
                    builder.govuk_collection_radio_buttons(:favourite_colour, colours, :id, :name)
                  ]
                )
              end
            end

            specify 'the error message should link to only one radio button' do
              expect(subject).to have_tag('a', with: { href: "#" + identifier })
              expect(subject).to have_tag('input', with: { type: 'radio', id: identifier }, count: 1)
            end

            specify 'the radio button linked to should be first' do
              first_radio = parsed_subject.css('input').find { |e| e['type'] == 'radio' }

              expect(first_radio['id']).to eql(identifier)
            end

            specify 'there should be a label associated with the error link target' do
              first_label = parsed_subject.css('label').first

              expect(first_label['for']).to eql(identifier)
            end
          end

          describe 'radio button fieldsets' do
            let(:object) { Person.new(favourite_colour: nil) }
            let(:identifier) { 'person-favourite-colour-field-error' }
            let(:second_radio_identifier) { 'person-favourite-colour-green-field' }
            subject do
              builder.tag.div do
                builder.safe_join(
                  [
                    builder.govuk_error_summary,
                    builder.govuk_radio_buttons_fieldset(:favourite_colour) do
                      builder.safe_join(
                        [
                          builder.govuk_radio_button(:favourite_colour, :red, label: { text: red_label }, link_errors: true),
                          builder.govuk_radio_button(:favourite_colour, :green, label: { text: green_label })
                        ]
                      )
                    end
                  ]
                )
              end
            end

            specify 'the error message should link to only one radio button' do
              expect(subject).to have_tag('a', with: { href: "#" + identifier })
              expect(subject).to have_tag('input', with: { type: 'radio', id: identifier }, count: 1)
            end

            specify 'the radio button linked to should be first' do
              first_radio = parsed_subject.css('input').find { |e| e['type'] == 'radio' }

              expect(first_radio['id']).to eql(identifier)
            end

            specify 'there should be a label associated with the error link target' do
              first_label = parsed_subject.css('label').first

              expect(first_label['for']).to eql(identifier)
            end

            specify 'the second radio button should have a regular id' do
              expect(subject).to have_tag('input', with: { id: second_radio_identifier })
            end
          end

          describe 'check box collections' do
            let(:object) { Person.new(projects: nil) }
            let(:identifier) { 'person-projects-field-error' }
            subject do
              builder.tag.div do
                builder.safe_join(
                  [
                    builder.govuk_error_summary,
                    builder.govuk_collection_check_boxes(:projects, projects, :id, :name)
                  ]
                )
              end
            end

            specify 'the error message should link to only one check box' do
              expect(subject).to have_tag('a', with: { href: "#" + identifier })
              expect(subject).to have_tag('input', with: { type: 'checkbox', id: identifier }, count: 1)
            end

            specify 'the check box linked to should be first' do
              first_checkbox = parsed_subject.css('input').find { |e| e['type'] == 'checkbox' }

              expect(first_checkbox['id']).to eql(identifier)
            end

            specify 'there should be a label associated with the error link target' do
              first_label = parsed_subject.css('label').first

              expect(first_label['for']).to eql(identifier)
            end
          end

          describe 'check box fieldsets' do
            let(:object) { Person.new }
            let(:identifier) { 'person-projects-field-error' }
            let(:second_checkbox_identifier) { %(person-projects-#{project_y.id}-field) }
            subject do
              builder.tag.div do
                builder.safe_join(
                  [
                    builder.govuk_error_summary,
                    builder.govuk_check_boxes_fieldset(:projects) do
                      builder.safe_join(
                        [
                          builder.govuk_check_box(:projects, project_x.id, label: { text: project_x.name }, link_errors: true),
                          builder.govuk_check_box(:projects, project_y.id, label: { text: project_y.name })
                        ]
                      )
                    end
                  ]
                )
              end
            end

            specify 'the error message should link to only one check box' do
              expect(subject).to have_tag('a', with: { href: "#" + identifier })
              expect(subject).to have_tag('input', with: { type: 'checkbox', id: identifier }, count: 1)
            end

            specify 'the checkbox button linked to should be first' do
              first_checkbox = parsed_subject.css('input').find { |e| e['type'] == 'checkbox' }

              expect(first_checkbox['id']).to eql(identifier)
            end

            specify 'there should be a label associated with the error link target' do
              first_label = parsed_subject.css('label').first

              expect(first_label['for']).to eql(identifier)
            end

            specify 'the second radio button should have a regular id' do
              expect(subject).to have_tag('input', with: { id: second_checkbox_identifier })
            end
          end

          describe 'date fields' do
            let(:object) { Person.new(born_on: Date.today.next_year(5)) }
            let(:identifier) { 'person-born-on-field-error' }

            # 1i is year, 2i is month, 3i is day - we're only dealing with day and month here
            { true => '2i', false => '3i' }.each do |omit_day, segment|
              context "when omit_day is #{omit_day}" do
                let(:first_date_segment_name) { "person[born_on(#{segment})]" }
                subject do
                  builder.tag.div do
                    builder.safe_join(
                      [
                        builder.govuk_error_summary,
                        builder.govuk_date_field(:born_on, omit_day: omit_day)
                      ]
                    )
                  end
                end

                specify 'the error message should link to only one check box' do
                  expect(subject).to have_tag('a', with: { href: "#" + identifier })
                  expect(subject).to have_tag('input', with: { id: identifier }, count: 1)
                end

                specify 'the targetted input should be the first field' do
                  expect(parsed_subject.css("input").first).to eql(parsed_subject.at_css('#' + identifier))
                end

                specify 'the targetted input should be the day field' do
                  expect(parsed_subject.at_css('#' + identifier).attribute('name').value).to eql(first_date_segment_name)
                end
              end
            end
          end
        end

        describe "custom sort order" do
          let(:actual_order) { extract_field_names_from_errors_summary_list(parsed_subject) }

          context "by default" do
            # the object here is Person, defined in spec/support/examples.rb
            #
            # the validation order is: name, favourite colour, projects, cv
            #
            # name is present on the object
            specify "errors are displayed in the order they're defined in the model" do
              expect(object.name).to be_present

              expect(actual_order).to eql(%w(favourite_colour projects cv))
            end
          end

          describe "overriding" do
            let(:object) { OrderedErrors.new }
            let(:overridden_order) { %w(e d c b a) }
            let(:overridden_order_symbols) { overridden_order.map(&:to_sym) }
            let(:kwargs) { { order: overridden_order_symbols } }

            context "when all attributes are named in the ordering" do
              # the default validation order is (:a, :b, :c, :d, :e)
              #
              # the overridden order is (:e, :d, :c, :b, :a)
              specify "the error messages are displayed in the overridden order" do
                expect(actual_order).to eql(overridden_order)
              end
            end

            context "when there are attributes with errors that aren't named in the ordering" do
              let(:object) { OrderedErrorsWithCustomOrderAndExtraAttributes.new }

              # the default validation order is (:a, :b, :c, :d, :e)
              #
              # the overridden order is (:e, :d, :c, :b, :a)
              #
              # the extra attributes (:g, :h, :i) validation order is (:i, :h, :g)
              specify "the errors for attributes with overridden ordering are first" do
                expect(actual_order).to start_with(overridden_order)
              end

              specify "the errors for extra attributes appear last, in the order they were defined in the model" do
                expect(actual_order).to end_with(%w(i h g))
              end
            end

            context "when the ordering specifies attributes that aren't present on the object" do
              let(:kwargs) { { order: overridden_order_symbols.append(%i(x y z)) } }

              # there's no error_order method, ensure it doesn't blow up. it shouldn't
              # because #index will return nil
              specify "the error messages are displayed in the order they were defined in the model" do
                expect(actual_order).to eql(overridden_order)
              end
            end
          end
        end
      end
    end

    context 'when the object has no errors' do
      let(:object) { Person.valid_example }
      subject { builder.send(method) }

      specify 'no error summary should be present' do
        expect(subject).to be_nil
      end
    end

    context 'when the object does not support errors' do
      let(:object) { Guest.example }
      subject { builder.send(method) }

      specify 'an error should be raised' do
        expect { subject }.to raise_error(NoMethodError, /errors/)
      end
    end

    describe 'when there are errors on the base object' do
      let(:object) { Person.with_errors_on_base }
      let(:error) { object.errors[:base].first }

      context 'when an override is specified' do
        let(:link_base_errors_to) { :name }
        subject { builder.send(method, link_base_errors_to: link_base_errors_to) }

        specify 'the override field should be linked to' do
          expect(subject).to have_tag("a", text: error, with: { href: %(#person-#{link_base_errors_to}-field) })
        end
      end

      context 'when no override is specified' do
        subject { builder.send(method) }

        specify 'the base field should be linked to' do
          expect(subject).to have_tag("a", text: error, with: { href: %(#person-base-field-error) })
        end
      end
    end

    context 'extra attributes' do
      before { object.valid? }

      it_behaves_like 'a field that allows extra HTML attributes to be set' do
        let(:described_element) { 'div' }
        let(:expected_class) { 'govuk-error-summary' }
      end
    end

    context 'when a block of html is supplied' do
      let(:custom_content_tag) { :marquee }
      let(:custom_content_text) { "Fix the things below" }
      subject do
        builder.send(*args) do
          builder.content_tag(custom_content_tag, custom_content_text)
        end
      end

      before { object.valid? }

      specify "the custom content should be present in the error summary" do
        expect(subject).to have_tag("div", with: { class: "govuk-error-summary" }) do
          with_tag("div", with: { class: "govuk-error-summary__body" }) do
            with_tag(custom_content_tag, text: custom_content_text)
          end
        end
      end
    end
  end
end
