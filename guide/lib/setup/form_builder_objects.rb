module Setup
  module FormBuilderObjects

    def builder(errors = false)
      errors ? builder_with_errors : builder_without_errors
    end

    def builder_without_errors
      GOVUKDesignSystemFormBuilder::FormBuilder.new(:person, object, helper, {})
    end

    def builder_with_errors
      GOVUKDesignSystemFormBuilder::FormBuilder.new(:person, object_with_errors, helper, {})
    end

    def object
      Person.new
    end

    def object_with_errors
      Person.new.tap { |p| p.valid? }
    end

    def helper
      TestHelper.new
    end
  end
end
