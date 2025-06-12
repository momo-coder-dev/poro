class Blocks::EventsFilterComponent < ViewComponent::Base
  def initialize(categories:, venues:, params:)
    @categories = categories
    @venues = venues
    @params = params
  end

  private

  attr_reader :categories, :venues, :params
end 