module Examples
  module Password
    def default_password
      <<~PASSWORD
        = f.govuk_password_field :password, label: { text: "Enter your password" }
      PASSWORD
    end

    def password_with_a_captioned_heading_label_and_hint
      <<~PASSWORD
        = f.govuk_password_field(:pin,
            label: { text: "Enter your PIN", tag: "h2", size: "l" },
            caption: { text: "Security", size: "m" },
            hint: { text: "Your PIN was emailed to you when you registered for this service" })
      PASSWORD
    end

    def password_with_custom_text
      <<~PASSWORD
        = f.govuk_password_field(:secret_code,
            label: { text: "Enter your secret code" },
            show_password_text: "Display",
            hide_password_text: "Conceal",
            show_password_aria_label_text: "Display the secret code",
            hide_password_aria_label_text: "Conceal the secret code",
            password_shown_announcement_text: "The secret code has been displayed",
            password_hidden_announcement_text: "The secret code has been concealed")
      PASSWORD
    end
  end
end
