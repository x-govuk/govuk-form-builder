module Examples
  module File
    def file_upload
      <<~SNIPPET
        = f.govuk_file_field :profile_photo,
          label: { text: 'Identification photograph' },
          hint: { text: 'Upload a clear colour photograph of yourself looking straight at the camera' }
      SNIPPET
    end

    def file_upload_javascript
      <<~SNIPPET
        = f.govuk_file_field :profile_photo,
          label: { text: 'Identification photograph' },
          hint: { text: 'Upload a clear colour photograph of yourself looking straight at the camera' },
          javascript: true
      SNIPPET
    end

    def file_upload_javascript_with_custom_text
      <<~SNIPPET
        = f.govuk_file_field :profile_photo,
          label: { text: "Llwythwch ffeil i fyny" },
          javascript: true,
          choose_files_button_text: "Dewiswch ffeil",
          drop_instruction_text: "neu ollwng ffeil",
          no_file_chosen_text: "Dim ffeil wedi'i dewis",
          multipleFilesChosenText: { "other" => "%{count} ffeil wedi'u dewis", "one" => "%{count} ffeil wedi'i dewis"},
          entered_drop_zone_text: "Wedi mynd i mewn i'r parth gollwng",
          left_drop_zone_text: "Parth gollwng i'r chwith"
      SNIPPET
    end
  end
end
