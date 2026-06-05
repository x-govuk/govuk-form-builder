module Examples
  module TextArea
    def text_area
      "= f.govuk_text_area :responsibilities"
    end

    def text_area_with_label_and_hint_and_nine_rows
      <<~SNIPPET
        = f.govuk_text_area :job_description,
          label: { text: 'Job description' },
          hint: { text: 'Describe your typical day' },
          rows: 9
      SNIPPET
    end

    def text_area_with_max_words
      <<~SNIPPET
        = f.govuk_text_area :cv,
          label: { text: 'Curriculum vitae' },
          max_words: 20
      SNIPPET
    end

    def text_area_with_max_chars_and_threshold
      <<~SNIPPET
        = f.govuk_text_area :education_history,
          label: { text: 'Education history' },
          max_chars: 10,
          threshold: 50
      SNIPPET
    end

    def text_area_with_custom_limit_text
      <<~SNIPPET
        = f.govuk_text_area :personal_statement,
          label: { text: 'Déclaration personnelle' },
          max_chars: 20,
          under_limit_other_text: '%{count} caractères restants' ,
          under_limit_one_text: '%{count} caractère restant',
          at_limit_text: 'Plus aucun caractère restant',
          over_limit_other_text: '%{count} caractères de trop' ,
          over_limit_one_text: '%{count} caractère de trop'
      SNIPPET
    end
  end
end
