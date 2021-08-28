module GOVUKDesignSystemFormBuilder
  module Presenters
    class ErrorSummary
      # @return [String] summary error message for the given attribute and messages
      #
      # @param attribute [String, Symbol] name of the attribute that is invalid
      # @param messages [Array<String>, <Symbol>] list of error messages on that attribute
      #
      # @see https://design-system.service.gov.uk/components/error-summary/ GOV.UK error summary
      def message_for(_attribute, messages)
        messages.first
      end
    end
  end
end
