module Examples
  module TextArea
    def text_area
      "= f.govuk_text_area :responsibilities"
    end

    def text_area_with_label_and_hint_and_nine_rows
      <<~SNIPPET
        = f.govuk_text_area :job_description,
          label: { text: 'Job description' },
          hint_text: 'Describe your typical day',
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
  end
end
