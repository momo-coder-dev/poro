class Blocks::EventsCardComponent < ViewComponent::Base
  def initialize(events:)
    @events = events
  end

  private

  attr_reader :events
end 