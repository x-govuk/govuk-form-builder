module Presenters
  # This is the default presenter for {GOVUKDesignSystemFormBuilder::Elements::ErrorSummary} and is
  # intended to be easily replaceable should you have specific requirements that aren't met here.
  #
  # The basic behaviour is to always show the first error message. In Rails, error message order is
  # determined by the order in which the validations run, but if you need to do any other transformation
  # or concatenation, this is the place to do it.
  class ErrorSummaryPresenter
    # @param [Hash] error_messages the error message hash in a format that matches Rails'
    #   `object.errors.messages`, so the format should be:
    #
    # @example Input format:
    #   ErrorSummaryPresenter.new({ attribute_one: ["first error", "second error"], attribute_two: ["third error"] })
    def initialize(error_messages)
      @error_messages = error_messages
    end

    # Converts +@error_messages+ into an array of argument arrays that will be
    # passed into {GOVUKDesignSystemFormBuilder::Elements::ErrorSummary#list_item}.
    #
    # @example Output format given the input above:
    #   [[:attribute_one, "first error"], [:attribute_two, "third error"]]
    def formatted_error_messages
      @error_messages.map { |attribute, messages| [attribute, messages.first] }
    end
  end
end
