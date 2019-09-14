# GOV.UK Design System Form Builder for Rails

[![Build Status](https://travis-ci.com/DFE-Digital/govuk_design_system_formbuilder.svg?branch=master)](https://travis-ci.com/DFE-Digital/govuk_design_system_formbuilder)
[![Maintainability](https://api.codeclimate.com/v1/badges/fde73b5dc9476197281b/maintainability)](https://codeclimate.com/github/DFE-Digital/govuk_design_system_formbuilder/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/fde73b5dc9476197281b/test_coverage)](https://codeclimate.com/github/DFE-Digital/govuk_design_system_formbuilder/test_coverage)
[![Gem Version](https://badge.fury.io/rb/govuk_design_system_formbuilder.svg)](https://badge.fury.io/rb/govuk_design_system_formbuilder)
[![Netlify Status](https://api.netlify.com/api/v1/badges/d4c50b8d-6ca3-4797-9ab3-6e0731c72b44/deploy-status)](https://app.netlify.com/sites/govuk-form-builder/deploys)

This gem provides a easy-to-use form builder that generates forms that are
fully-compliant with version 3.2.0 of the [GOV.UK Design System](https://design-system.service.gov.uk/),
minimising the amount of markup you need to write.

The latest version of this gem that supports GOV.UK Design System version 2 is
[0.7.10](https://github.com/DFE-Digital/govuk_design_system_formbuilder/releases/tag/v0.7.10).

In addition to the basic markup, the more-advanced functionality of the Design
System is exposed via the API. Adding [JavaScript-enhanced word count
checking](https://govuk-form-builder.netlify.com/form-elements/text-area/)
to text areas or [setting the size and weight of
labels](https://govuk-form-builder.netlify.com/introduction/labels-hints-and-legends/)
on text fields requires only a single argument.

If you're still not sure what a form builder is or how it works, don't worry!
[This screencast](https://www.youtube.com/watch?v=PhoFZ0qXAlA) should give you
an idea of what's on offer and [the official guide](https://govuk-form-builder.netlify.com) goes
into a bit more depth on how everything works 😅

## What's included

* 100% compatibility with the GOV.UK Design System
* Full control of labels, hints, fieldsets and legends
* No overwriting of Rails' default form helpers
* Automatic ARIA associations between hints, errors and inputs
* Most helpers take blocks for arbitrary content
* Additional params for programmatically adding hints to check box and radio
  button collections
* No external dependencies
* An exhaustive test suite
* [Extensive documentation](https://www.rubydoc.info/gems/govuk_design_system_formbuilder/GOVUKDesignSystemFormBuilder/Builder)
* [A full guide](https://govuk-form-builder.netlify.com/)

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
bundle exec rspec -fd
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
