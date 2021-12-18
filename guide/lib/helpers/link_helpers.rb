module Helpers
  module GOVUKLinkToHelpers
    def link_to(*args, **kwargs)
      return super if kwargs.key?('class')

      super(*args, **kwargs.merge(class: 'govuk-link'))
    end
  end

  module TitleAnchorHelpers
    def anchor_id(caption)
      caption.parameterize
    end
  end

  module LinkHelpers
    def code_climate_report_link
      'https://codeclimate.com/github/DFE-Digital/govuk_design_system_formbuilder'
    end

    def documentation_link
      'https://www.rubydoc.info/gems/govuk_design_system_formbuilder/GOVUKDesignSystemFormBuilder/Builder'
    end

    def config_documentation_link
      'https://www.rubydoc.info/gems/govuk_design_system_formbuilder/GOVUKDesignSystemFormBuilder'
    end

    def github_link
      'https://github.com/DFE-Digital/govuk-formbuilder'
    end

    def design_system_link
      'https://design-system.service.gov.uk'
    end

    def national_archives_link
      'https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/'
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

    def dfe_rails_boilerplate_link
      'https://github.com/DFE-Digital/govuk-rails-boilerplate'
    end

    def rails_initializer_link
      'https://guides.rubyonrails.org/configuring.html#using-initializer-files'
    end

    def slim_link
      'https://slim-lang.com'
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
      'https://github.com/DFE-Digital/govuk-formbuilder/issues'
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
  end
end
