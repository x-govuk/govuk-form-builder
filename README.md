# GOV.UK Design System Form Builder for Rails

## Installation

You can install the form builder gem by running the `gem install
govuk_design_system_formbuilder` or by adding the following line
to your `Gemfile`

```
gem 'govuk_design_system_formbuilder'
```

## Setup

To use the form builder in an ad hoc basis you can specify it
as an argument to `form_for`


```slim
= form_for @person, builder: GOVUKDesignSystemFormBuilder::FormBuilder do |f|
  = f.govuk_text_field :full_name
```


To set it globally, just add this to your `ApplicationController`


```ruby
class ApplicationController < ActionController::Base
  default_form_builder GOVUKDesignSystemFormBuilder::FormBuilder
end
```
