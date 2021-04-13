require 'rspec/expectations'

RSpec::Matchers.define(:have_root_element_with_class) do |class_name|
  # We're using xpath here because there's no sane way (ie without wrapping
  # everything in a useless element just for testing) of checking that elements
  # appear at the root of the fragment
  #
  # Note that the ./* matches ANY element `*` at the root `./` of the fragment
  match do |nokogiri_fragment|
    !nokogiri_fragment.xpath(%(./*[contains(concat(" ", @class, " "), " #{class_name} ")])).empty?
  end

  #:nocov:
  failure_message do |nokogiri_fragment|
    "expected that #{class_name} would be a class of a root element in fragment: #{nokogiri_fragment}"
  end
  #:nocov:
end

RSpec::Matchers.define(:have_no_leading_or_trailing_spaces) do
  match do |string|
    [string.start_with?(' '), string.end_with?(' ')].none?
  end

  #:nocov:
  failure_message do |failing_attribute|
    %('#{failing_attribute}' has leading or trailing spaces)
  end
  #:nocov:
end

RSpec::Matchers.define(:have_no_double_spaces) do
  match { |string| string !~ %r(\s{2}) }

  #:nocov:
  failure_message do |failing_attribute|
    %('#{failing_attribute}' has double spaces)
  end
  #:nocov:
end

RSpec::Matchers.define(:contain_element) do |selector|
  match do |nokogiri_fragment|
    @actual_values = nokogiri_fragment
                       .at_css(selector)
                       .attributes[@attribute]
                       .value
                       .split
                       .to_set

    @actual_values.superset?(@expected_values)
  end

  chain(:with_attribute) do |attribute|
    @attribute = attribute
  end

  chain(:that_has_values) do |*values|
    @expected_values = values.to_set
  end

  # :nocov:
  def format_array(arr)
    arr.to_a.map { |element| %("#{element}") }.join(', ')
  end

  failure_message do
    %([#{format_array(@actual_values)}] does not contain all of [#{format_array(@expected_values)}])
  end
  # :nocov:
end
