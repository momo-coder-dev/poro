class AccountDecorator < Draper::Decorator
  delegate_all

  def member_since
    created_at.strftime("%B %Y")
  end

  def total_events_count
    events.published.count
  end

  def upcoming_events_count
    events.published.upcoming.count
  end

  def past_events_count
    events.published.past.count
  end

  def formatted_phone
    return nil unless phone.present?
    phone.gsub(/(\d{3})(\d{3})(\d{4})/, '(\1) \2-\3')
  end
end 