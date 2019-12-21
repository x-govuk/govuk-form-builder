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

    def role_name
      <<~SNIPPET
        = f.govuk_text_field :role, label: { size: 'm' }
      SNIPPET
    end

    def custom_locale
      <<~LOCALE
        helpers:
          label:
            person:
              role: What role do you play?

        copy:
          descriptions:
            hint:
              subdivision:
                person:
                  role: |-
                    Roles may be achieved or ascribed or they can be accidental
                    in different situations. An achieved role is a position
                    that a person assumes voluntarily which reflects personal
                    skills, abilities, and effort.
      LOCALE
    end

    def reset_config
      GOVUKDesignSystemFormBuilder.reset!
    end
  end
end
