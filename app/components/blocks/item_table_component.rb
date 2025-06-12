# frozen_string_literal: true

class Blocks::ItemTableComponent < ViewComponent::Base
  def initialize(filter: {}, items:, headers:, rows:, actions: [], pagy: nil, policy_class: nil, scope: [], empty_state: {})
    @filter = filter
    @items = items
    @scope = scope
    @policy_class = policy_class
    @item_type = items.respond_to?(:object) ? items.object.klass.name : items.klass.name
    @item_type = to_snake_case(@item_type)
    @headers = headers
    @rows = rows
    @pagy = pagy
    @actions = actions
    @route_base = @scope.present? ? "#{@scope.join('_')}_#{@item_type}" : @item_type
    @empty_state = empty_state
  end

  private

  def get_item_attribute(item, attribute)
    return item.send(attribute) if item.respond_to?(attribute)
    return item.object.send(attribute) if item.respond_to?(:object) && item.object.respond_to?(attribute)
    nil
  end

  def check_policy(item, action)
    return true if @policy_class.nil?
    @policy_class.new(helpers.current_user, item).send(action.to_s + "?")
  end

  def route_params(item)
    params = {}
    @scope.each do |s|
      params[:"#{s}_id"] = item.send("#{s}_id") if item.class.column_names.include?("#{s}_id")
    end
    params[:id] = item.id
    params
  end

  def format_action(action_data)
    if (action_data.is_a? String)|| (action_data.is_a? Symbol)
      action = action_data.to_s
      path = determine_path(action)
      method = determine_common_action_method(action)
      name = action
    elsif action_data.is_a? Array
      action, name, method = action_data
      method = determine_common_action_method(action) if method.nil?
      path = determine_path(action)

    end
    [ path, method, name ]
  end

  def determine_path(action)
    return "#{@route_base}_path" if action.to_s == "show"
    return "#{@route_base}_path" if action.to_s == "destroy"
    "#{action}_#{@route_base}_path"
  end

  def determine_common_action_method(action)
    return "delete" if action.to_s == "destroy"
    "get"
  end

  def footer?
    @pagy.present?
  end

  def to_snake_case(str)
    str.underscore
  end

  def empty_state_options
    {
      title: @empty_state[:title] || "No #{@item_type.pluralize.humanize.downcase} found",
      description: @empty_state[:description] || "Get started by creating a new #{@item_type.humanize.downcase}.",
      button_text: @empty_state[:button_text] || "New #{@item_type.humanize}",
      button_path: @empty_state[:button_path] || helpers.send("new_#{@route_base}_path")
    }
  end

  # [ :validate, :show ]
  # [ "validate", "show" ]
  # [ { name: "Valider", method: "POST", type: "edit" } ]
  # [ { name: "Valider", method: "POST", type: "edit" } ]
end
