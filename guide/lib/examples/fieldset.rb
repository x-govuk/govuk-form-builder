module Examples
  module Radios
    def address_fieldset
      <<~SNIPPET
        = f.govuk_fieldset legend: { text: 'Where do you live?' } do
          = f.govuk_text_field :address_one,   width: 'one-half',    label: { text: 'House number and street' }
          = f.govuk_text_field :address_two,   width: 'one-half',    label: { text: 'Town', hidden: true }
          = f.govuk_text_field :address_three, width: 'one-half',    label: { text: 'City' }
          = f.govuk_text_field :postcode,      width: 'one-quarter', label: { text: 'Postcode' }
      SNIPPET
    end
  end
end
