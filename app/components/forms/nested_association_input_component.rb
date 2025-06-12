class Forms::NestedAssociationInputComponent < Forms::BaseElementComponent
  def after_initialize
    @model = @field_name.to_s.classify.constantize
    @fields = @options[:fields]
  end

  def has_many_association?
    r = @object.class.reflect_on_association(@model.name.underscore.to_sym)
    r = @object.class.reflect_on_association(@model.name.underscore.pluralize.to_sym) if r.nil?
    r.present? && r.macro == :has_many
  end

  def has_one_association?
    @object.class.reflect_on_association(@model.name.underscore.to_sym).macro == :has_one
  end
end
