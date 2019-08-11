module BuilderExamples
  def builder
    GOVUKDesignSystemFormBuilder::FormBuilder.new(:person, object, helper, {})
  end

  def object
    Person.new
  end

  def helper
    TestHelper.new
  end
end
