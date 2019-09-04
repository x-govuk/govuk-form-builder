module Examples
  module File
    def file_upload
      <<~SNIPPET
        = f.govuk_file_field :profile_photo,
          label: { text: 'Identification photograph' },
          hint_text: 'Upload a clear colour photograph of yourself looking straight at the camera'
      SNIPPET
    end
  end
end
