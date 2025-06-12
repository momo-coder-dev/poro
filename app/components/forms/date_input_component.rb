
class Forms::DateInputComponent < Forms::BaseElementComponent
  def after_initialize
    @enable_time = @options[:enable_time].presence || false
    @enable_seconds = @options[:enable_seconds].presence || false
    @min_date = @options[:min_date].presence || nil
  end
end
