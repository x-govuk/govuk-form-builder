module Helpers
  module TitleAnchorHelpers
    def anchor_id(caption)
      caption.parameterize
    end
  end

  module LinkHelpers
    def navigation_links
      {
        "Introduction" => {
          "Get started" => "/introduction/get-started/",
          "Configuration" => "/introduction/configuration/",
          "Labels, captions, hints and legends" => "/introduction/labels-captions-hints-and-legends/",
          "Error handling" => "/introduction/error-handling/",
          "Supported versions" => "/introduction/supported-versions/",
        },
        "Building blocks" => {
          "Injecting content" => "/building-blocks/injecting-content/",
          "Fieldsets" => "/building-blocks/fieldsets/",
          "Localisation" => "/building-blocks/localisation/",
        },
        "Form elements" => {
          "Checkboxes" => "/form-elements/checkboxes/",
          "Date input" => "/form-elements/date-input/",
          "File upload" => "/form-elements/file-upload/",
          "Password input" => "/form-elements/password-input/",
          "Radios" => "/form-elements/radios/",
          "Select" => "/form-elements/select/",
          "Submit button" => "/form-elements/submit/",
          "Textarea" => "/form-elements/textarea/",
          "Text input" => "/form-elements/text-input/",
        }
      }
    end

    def code_climate_report_link
      'https://codeclimate.com/github/x-govuk/govuk-form-builder'
    end

    def documentation_link
      'https://www.rubydoc.info/gems/govuk_design_system_formbuilder/GOVUKDesignSystemFormBuilder/Builder'
    end

    def config_documentation_link
      'https://www.rubydoc.info/gems/govuk_design_system_formbuilder/GOVUKDesignSystemFormBuilder'
    end

    def github_link
      'https://github.com/x-govuk/govuk-form-builder'
    end

    def github_release_2_8_0
      'https://github.com/x-govuk/govuk-form-builder/releases/tag/v2.8.0'
    end

    def design_system_link
      'https://design-system.service.gov.uk'
    end

    def licence_link
      'https://github.com/x-govuk/govuk-components/blob/main/LICENSE.txt'
    end

    def rubygems_link
      'https://rubygems.org/gems/govuk_design_system_formbuilder'
    end

    def prevent_double_click_link
      'https://design-system.service.gov.uk/components/button/#stop-users-from-accidentally-sending-information-more-than-once'
    end

    def input_types_for_numbers_link
      'https://technology.blog.gov.uk/2020/02/24/why-the-gov-uk-design-system-team-changed-the-input-type-for-numbers/'
    end

    def dfe_rails_template_link
      'https://github.com/DFE-Digital/rails-template'
    end

    def rails_initializer_link
      'https://guides.rubyonrails.org/configuring.html#using-initializer-files'
    end

    def slim_link
      'https://github.com/slim-template/slim'
    end

    def erb_link
      'https://ruby-doc.org/stdlib-2.6.4/libdoc/erb/rdoc/ERB.html'
    end

    def haml_link
      'https://haml.info'
    end

    def version_supporting_design_system_v2
      'https://rubygems.org/gems/govuk_design_system_formbuilder/versions/0.7.10'
    end

    def rails_localisation_link
      'https://guides.rubyonrails.org/i18n.html'
    end

    def ruby_proc_link
      'https://ruby-doc.org/core-2.6.5/Proc.html'
    end

    def project_new_issue_link
      'https://github.com/x-govuk/govuk-form-builder/issues'
    end

    def nhs_design_system_link
      'https://service-manual.nhs.uk/design-system'
    end

    def rails_checkbox_gotcha_link
      'https://edgeapi.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-check_box-label-Gotcha'
    end

    def rails_option_for_select_link
      'https://edgeapi.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html#method-i-options_for_select'
    end

    def rails_grouped_option_for_select_link
      'https://edgeapi.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html#method-i-grouped_options_for_select'
    end

    def rails_option_groups_from_collection_for_select_link
      'https://edgeapi.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html#method-i-option_groups_from_collection_for_select'
    end

    def rails_options_from_collection_for_select_link
      'https://edgeapi.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html#method-i-options_from_collection_for_select'
    end

    def govuk_forms_link
      "https://www.forms.service.gov.uk/"
    end

    def moj_forms_link
      "https://moj-forms.service.justice.gov.uk/"
    end
  end
end
