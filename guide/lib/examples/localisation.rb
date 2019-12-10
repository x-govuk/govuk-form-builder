module Examples
  module Localisation
    def favourite_kind_of_hat_locale
      <<~LOCALE
        helpers:
          label:
            person:
              favourite_kind_of_hat: Which style of hat do you prefer?
          hint:
            person:
              favourite_kind_of_hat: |-
                Trilby, Stetson, Deerstalker, Fez, Top and Beret are
                the most-fashionable
      LOCALE
    end

    def favourite_kind_of_hat
      <<~SNIPPET
        = f.govuk_text_field :favourite_kind_of_hat, label: { size: 'm' }
      SNIPPET
    end
  end
end
