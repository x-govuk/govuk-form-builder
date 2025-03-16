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
  end
end
