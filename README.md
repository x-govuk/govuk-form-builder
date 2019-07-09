# GOV.UK Design System Form Builder for Rails

This gem provides a easy-to-use form builder that generates forms that are
fully-compliant with the [GOV.UK Design System](https://design-system.service.gov.uk/),
minimising the amount of markup you need to write.

In addition to the basic markup, the more-advanced functionality of the Design
System is exposed via the API. Adding [JavaScript-enhanced word count
checking](https://www.rubydoc.info/gems/govuk_design_system_formbuilder/GOVUKDesignSystemFormBuilder/Builder#govuk_text_area-instance_method)
to text areas or [setting the size and weight of
labels](https://www.rubydoc.info/gems/govuk_design_system_formbuilder/GOVUKDesignSystemFormBuilder/Builder#govuk_text_field-instance_method)
on text fields requires only a single argument.

If you're still not sure what a form builder is or how it works, don't worry!
[This screencast](https://www.youtube.com/watch?v=PhoFZ0qXAlA) should give you
an idea of what's on offer 😅

## What's included

* 100% compatibility with the GOV.UK Design System
* Full control of labels, hints, fieldsets and legends
* No overwriting of Rails' default form helpers
* Automatic ARIA associations between hints, errors and inputs
* Most helpers take blocks for arbitrary content
* Additional params for programmatically adding hints to check box and radio
  button collections
* No external dependencies
* [Extensive documentation](https://www.rubydoc.info/gems/govuk_design_system_formbuilder/GOVUKDesignSystemFormBuilder/Builder)
* An exhaustive test suite

## Installation

You can install the form builder gem by running the `gem install
govuk_design_system_formbuilder` or by adding the following line
to your `Gemfile`:

```sh
gem 'govuk_design_system_formbuilder'
```

To make full use of this tool, you will need a Rails application with the latest [GOV.UK
Frontend](https://github.com/alphagov/govuk-frontend) assets installed and
configured.

To get up and running quickly and easily try kickstarting your project with a
pre-configured template:

* [DfE Boilerplate](https://github.com/DFE-Digital/govuk-rails-boilerplate)
* [MoJ Rails Template](https://github.com/ministryofjustice/moj_rails_template)

## Setup

To use the form builder in an ad hoc basis you can specify it
as an argument to `form_for` or `form_with`:

```slim
= form_for @some_object, builder: GOVUKDesignSystemFormBuilder::FormBuilder do |f|
  ...
```

To set it globally, just add this line to your `ApplicationController`:

```ruby
class ApplicationController < ActionController::Base
  default_form_builder GOVUKDesignSystemFormBuilder::FormBuilder
end
```

Now we can get started! 🎉

```slim
= form_for @person do |f|

  = f.govuk_text_field :full_name, label: { text: "Your full name" }

  = f.govuk_number_field :age, label: { text: "Age" }

  = f.govuk_collection_select :department_id,
    @departments,
    :id,
    :name,
    :description,
    label: { text: "Which department do you work for?" },
    hint_text: "If you don't know ask your manager" }

  = f.govuk_submit 'Away we go!'
```

## Developing and running the tests

The form builder is covered by RSpec, to run all the tests first ensure that
all of the development and testing prerequisite gems are installed. At the root
of a freshly-cloned repo run:

```sh
bundle
```

Now, if everything was successful, run RSpec:

```sh
rspec -fd
```

## Contributing

Bug reports and feature requests are most welcome, please raise an issue or
submit a pull request.

Currently we're using [GOVUK Lint](https://github.com/alphagov/govuk-lint) to
ensure code meets the GOV.UK guidelines. Please ensure that any PRs also adhere
to this standard.

## Thanks

This project was inspired by [MoJ's GovukElementsFormBuilder](https://github.com/ministryofjustice/govuk_elements_form_builder),
but is leaner, more modular and written in a more idiomatic style.
