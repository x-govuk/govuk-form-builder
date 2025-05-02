# GOV.UK Form Builder for Ruby on Rails

[![Tests](https://github.com/x-govuk/govuk-form-builder/workflows/Tests/badge.svg)](https://github.com/x-govuk/govuk-form-builder/actions)
[![Maintainability](https://api.codeclimate.com/v1/badges/110136fb22341d3ba646/maintainability)](https://codeclimate.com/github/x-govuk/govuk-form-builder/maintainability)
[![Gem version](https://badge.fury.io/rb/govuk_design_system_formbuilder.svg)](https://badge.fury.io/rb/govuk_design_system_formbuilder)
[![Gem](https://img.shields.io/gem/dt/govuk_design_system_formbuilder?logo=rubygems)](https://rubygems.org/gems/govuk_design_system_formbuilder)
[![Test Coverage](https://api.codeclimate.com/v1/badges/110136fb22341d3ba646/test_coverage)](https://codeclimate.com/github/x-govuk/govuk-form-builder/test_coverage)
[![GitHub license](https://img.shields.io/github/license/x-govuk/govuk-form-builder)](https://github.com/x-govuk/govuk-form-builder/blob/main/LICENSE)
[![GOV.UK Design System version](https://img.shields.io/badge/GOV.UK%20Design%20System-5.10.0-brightgreen)](https://design-system.service.gov.uk)
[![Rails](https://img.shields.io/badge/Rails-7.1.5%20%E2%95%B1%207.2.2%20%E2%95%B1%208.0.1-E16D6D)](https://weblog.rubyonrails.org/releases/)
[![Ruby](https://img.shields.io/badge/Ruby-3.2.6%20%20%E2%95%B1%203.3.6%20%20%E2%95%B1%203.4.1-E16D6D)](https://www.ruby-lang.org/en/downloads/)

This library provides an easy-to-use form builder for the [GOV.UK Design System](https://design-system.service.gov.uk/).

It is intended to make creating forms **quick**, **easy** and **familiar** for Ruby on Rails developers.

## Documentation

The gem comes with [a full guide](https://govuk-form-builder.netlify.app/) that covers most aspects of day-to-day use, along with code and output examples. The examples in the guide are generated from the builder itself so it will always be up to date.

[![Netlify Status](https://api.netlify.com/api/v1/badges/d4c50b8d-6ca3-4797-9ab3-6e0731c72b44/deploy-status)](https://app.netlify.com/sites/govuk-form-builder/deploys)

## What’s included

* 100% compatibility with the GOV.UK Design System
* Full control of labels, legends, hints, captions and fieldsets
* No overwriting of Rails’ default form helpers
* Automatic ARIA associations between hints, errors and inputs
* Most helpers take blocks for arbitrary content
* Additional params for programmatically adding hints to check box and radio button collections
* Full I18n support
* Automatic handling of ActiveRecord validation error messages
* No external dependencies
* An exhaustive test suite
* [Extensive technical documentation](https://www.rubydoc.info/gems/govuk_design_system_formbuilder/GOVUKDesignSystemFormBuilder/Builder)

## Installation

You can install the form builder gem by running the `gem install govuk_design_system_formbuilder` or by adding the following line to your `Gemfile`:

```sh
gem 'govuk_design_system_formbuilder'
```

To make full use of this tool, you will need a Rails application with the latest [GOV.UK Frontend](https://github.com/alphagov/govuk-frontend) assets installed and configured.

To get up and running quickly and easily try kickstarting your project with a pre-configured template:

* [DfE Rails Template](https://github.com/DFE-Digital/rails-template)
* [DEFRA Ruby Template](https://github.com/DEFRA/defra-ruby-template)

## Setup

To use the form builder in an ad hoc basis you can specify it as an argument to `form_for` or `form_with`. These examples are written in [Slim](https://github.com/slim-template/slim) but other templating languages like ERB and [Haml](https://haml.info/) work just as well.

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

Now we can get started!

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
    hint: { text: "If you don’t know ask your manager" }

  = f.govuk_submit 'Away we go!'
```

## Developing and running the tests

The form builder is tested with RSpec. To run all the tests first ensure that the development and testing prerequisite gems are installed. At the root of a freshly-cloned repo run:

```sh
bundle
```

Now, if everything was successful, run RSpec:

```sh
bundle exec rspec
```

## Contributing

Bug reports and feature requests are most welcome, please raise an issue or submit a pull request.

Currently we’re using [GOVUK Lint](https://github.com/alphagov/govuk-lint) to ensure code meets the GOV.UK guidelines. Please ensure that any PRs also adhere to this standard.

To help keep the logs clean and tidy, please configure git to use your full name:

```sh
git config --global user.name "Julius Hibbert"
```

## Services using this library

Approximately [100 services use this library](https://github.com/x-govuk/govuk-form-builder/network/dependents),
here are a few from the <abbr title="Department for Education">DfE</abbr>, <abbr title="Ministry of Justice">MoJ</abbr>, and
<abbr title="Department for Business, Energy & Industrial Strategy">BEIS</abbr>.

* [Apply for teacher training](https://www.github.com/dfe-digital/apply-for-teacher-training)
* [Teaching Vacancies](https://www.github.com/dfe-digital/teaching-vacancies)
* [Manage children's vaccinations](https://github.com/nhsuk/manage-childrens-vaccinations)
* [Claim for crown court defence](https://www.github.com/ministryofjustice/Claim-for-Crown-Court-Defence)
* [Appeal to the tax tribunal](https://www.github.com/ministryofjustice/tax-tribunals-datacapture)
* [Apply to court about child arrangements](https://www.github.com/ministryofjustice/c100-application)
* [Trade Tariff duty calculator](https://www.github.com/trade-tariff/trade-tariff-duty-calculator)
* [Report your official development assistance](https://www.github.com/UKGovernmentBEIS/beis-report-official-development-assistance)

## Form building services using this library

* [MoJ Forms](https://moj-forms.service.justice.gov.uk/)
* [GOV.UK Forms](https://www.forms.service.gov.uk/)

## Thanks

This project was inspired by [Ministry of Justice’s GovukElementsFormBuilder](https://github.com/ministryofjustice/govuk_elements_form_builder), but is leaner, more modular and written in a more idiomatic style.
