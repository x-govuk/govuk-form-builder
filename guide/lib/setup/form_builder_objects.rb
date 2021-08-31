module Setup
  module FormBuilderObjects
    def builder(errors = false)
      case errors
      when :fields
        builder_with_field_errors
      when :base
        builder_with_base_errors
      when :presenters
        builder_with_presenter_errors
      else
        builder_without_errors
      end
    end

    def builder_without_errors
      GOVUKDesignSystemFormBuilder::FormBuilder.new(:person, object, helper, {})
    end

    def builder_with_field_errors
      GOVUKDesignSystemFormBuilder::FormBuilder.new(:person, object_with_field_errors, helper, {})
    end

    def builder_with_base_errors
      GOVUKDesignSystemFormBuilder::FormBuilder.new(:person, object_with_base_errors, helper, {})
    end

    def builder_with_presenter_errors
      GOVUKDesignSystemFormBuilder::FormBuilder.new(:person, object_with_presenter_errors, helper, {})
    end

    def object
      Person.new
    end

    def object_with_field_errors
      Person.new.tap { |p| p.valid?(:fields) }
    end

    def object_with_base_errors
      Person.new.tap { |p| p.valid?(:base_errors) }
    end

    def object_with_presenter_errors
      Person.new.tap { |p| p.valid?(:presenters) }
    end

    def helper
      ActionView::Base.new(action_view_context, {}, nil)
    end

  private

    def action_view_context
      ActionView::LookupContext.new(nil)
    end
  end
end
