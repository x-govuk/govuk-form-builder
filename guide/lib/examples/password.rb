module Examples
  module Password
    def default_password
      <<~PASSWORD
        = f.govuk_password_field :password_1, label: { text: "Password" }
      PASSWORD
    end

    def password_with_a_captioned_heading_label_and_hint
      <<~PASSWORD
        = f.govuk_password_field(:password_2,
            label: { text: "Password", tag: "h2", size: "l" },
            caption: { text: "Security", size: "m" },
            hint: { text: "Don't tell anyone your password" })
      PASSWORD
    end

    def password_with_custom_text
      <<~PASSWORD
        = f.govuk_password_field(:password_3,
            label: { text: "Password", tag: "h2", size: "l" },
            show_password_text: "Mostra",
            hide_password_text: "Nascondi",
            show_password_aria_label_text: "Mostra la password",
            hide_password_aria_label_text: "Nascondi la password",
            password_shown_announcement_text: "La password è visibile",
            password_hidden_announcement_text: "La password non è visibile")
      PASSWORD
    end
  end
end
