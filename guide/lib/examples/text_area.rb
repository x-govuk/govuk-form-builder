module Examples
  module TextArea
    def text_area
      "= f.govuk_text_area :responsibilities"
    end

    def text_area_with_label_and_hint
      <<~SNIPPET
        = f.govuk_text_area :job_description,
          label: { text: 'Job description' },
          hint_text: 'Describe your typical day'
      SNIPPET
    end

    def text_area_with_max_words
      <<~SNIPPET
        = f.govuk_text_area :cv,
          label: { text: 'Curruclum vitae' },
          max_words: 20
      SNIPPET
    end
  end
end
