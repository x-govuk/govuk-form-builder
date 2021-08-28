class ErrorSummaryPresenter
  def message_for(attribute, messages)
    "Custom error for #{attribute} is #{messages.first.downcase}!"
  end
end
