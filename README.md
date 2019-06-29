# GOV.UK Design System Form Builder for Rails

## What's included

* 100% compatibility with the [GOV.UK Design System](https://design-system.service.gov.uk/)
* Full control of labels, hints, fieldsets and legends
* No overwriting of Rails' default form helpers
* Automatic ARIA associations between hints, errors and inputs
* Most helpers take a block for arbitrary content
* Additional params for programmatically adding hints to check box and radio
  button collections

## Installation

You can install the form builder gem by running the `gem install
govuk_design_system_formbuilder` or by adding the following line
to your `Gemfile`

```sh
gem 'govuk_design_system_formbuilder'
```

## Setup

To use the form builder in an ad hoc basis you can specify it
as an argument to `form_for`


```slim
= form_for @some_object, builder: GOVUKDesignSystemFormBuilder::FormBuilder do |f|
```

To set it globally, just add this to your `ApplicationController`

```ruby
class ApplicationController < ActionController::Base
  default_form_builder GOVUKDesignSystemFormBuilder::FormBuilder
end
```

Now we can get started! 🎉

```slim
= form_for @person do |f|

  = f.govuk_text_field :full_name, label: { text: 'Your full name' }

  = f.govuk_number_field :age, label: { text: 'Age' }

  = f.submit 'Away we go!'
```

## Developing and running the tests

The form builder is covered by RSpec, to run all the tests first ensure that
all of the development and testing prerequisite gems are installed. At the root
of a freshly-cloned repo run

```sh
bundle
```

Now, if everything was successful, run RSpec

```sh
rspec -fd
```

## Thanks

This project was inspired by [MoJ's GovukElementsFormBuilder](https://github.com/ministryofjustice/govuk_elements_form_builder),
but tackles some problems in a different manner. It provides the following
advantages by providing:

* no reliance on a custom proxy/block buffer
* idiomatic Ruby
* a modular codebase
* a more-robust test suite
