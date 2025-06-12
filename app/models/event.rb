class Event < ApplicationRecord
  # Associations
  belongs_to :account
  has_many :tickets
  has_many :ticket_types
  has_one :venue
  has_one_attached :cover_image

  accepts_nested_attributes_for :venue
  accepts_nested_attributes_for :ticket_types

  # Callbacks
  before_create :generate_public_reference

  # Enums
  enum :step, { general_info: 1, schedule: 2, location: 3, tickets: 4, visibility: 5 }, default: 1
  enum :category, { conference: "conference", formation: "formation", sports: "sports", anniversary: "anniversary", concert: "concert", workshop: "workshop", other: "other" }
  enum :status, { draft: "draft", published: "published", archived: "archived" }, default: "draft"
  enum :access_visibility, { public_event: "public_event", private_event: "private_event" }, default: "public_event"
  enum :location_type, { physical: "physical", virtual: "virtual" }, default: "physical"

  # Validations
  validates :step, presence: true
  validates :name, :description, :cover_image, :category, presence: true
  validates :start_at, :end_at, presence: true
  validate :end_after_start
  validates :venue, presence: true
  validates_associated :venue
  validates :ticket_types, presence: true
  validates_associated :ticket_types
  validates :status, :access_visibility, :entry_requirement, presence: true

  # Scopes
  scope :future, -> { where("start_at > ?", Time.current) }
  scope :published, -> { where(status: 'published') }
  scope :by_category, ->(category) { where(category: category) }
  scope :by_venue, ->(venue_name) { joins(:venue).where(venues: { name: venue_name }) }
  scope :upcoming, -> { where('start_at > ?', Time.current) }
  scope :past, -> { where('start_at <= ?', Time.current) }

  # Instance methods
  def past?
    end_at.present? && end_at < Time.current
  end

  def present?
    start_at.present? && start_at <= Time.current && end_at.present? && end_at >= Time.current
  end

  def future?
    start_at.present? && start_at > Time.current
  end

  def self.by_date_range(start_date, end_date)
    start_date = Date.parse(start_date) rescue nil
    end_date = Date.parse(end_date) rescue nil
    
    if start_date && end_date
      where('start_at BETWEEN ? AND ?', start_date.beginning_of_day, end_date.end_of_day)
    elsif start_date
      where('start_at >= ?', start_date.beginning_of_day)
    elsif end_date
      where('start_at <= ?', end_date.end_of_day)
    else
      all
    end
  end

  # Private methods
  private

  def generate_public_reference
    loop do
      ref = "#{('A'..'Z').to_a.sample}#{rand(1000..9999)}"
      unless self.class.exists?(public_reference: ref)
        self.public_reference = ref
        break
      end
    end
  end

  # Custom validators
  def end_after_start
    return if end_at.blank? || start_at.blank?
    errors.add(:end_at, "doit être après la date de début") if end_at < start_at
  end
end


# class Event < ApplicationRecord
#   # Associations
#   belongs_to :account
#   has_many :tickets
#   has_many :ticket_types
#   has_one :venue
#   has_one_attached :cover_image

#   accepts_nested_attributes_for :venue
#   accepts_nested_attributes_for :ticket_types

#   # Callbacks
#   before_create :generate_public_reference

#   # Enums
#   enum :step, {
#     general_info: 1, schedule: 2,
#     location: 3, tickets: 4, visibility: 5
#   }, default: 1

#   enum :category, {
#     conference: "conference", formation: "formation", sports: "sports",
#     anniversary: "anniversary", concert: "concert", workshop: "workshop",
#     other: "other"
#   }

#   enum :status, {
#     draft: "draft", published: "published", archived: "archived"
#   }, default: "draft"

#   enum :access_visibility, {
#     public_event: "public_event", private_event: "private_event"
#   }, default: "public_event"

#   enum :location_type, {
#     physical: "physical", virtual: "virtual"
#   }, default: "physical"

#   # Validations
#   validates :step, presence: true

#   # Step-based Validations

#   # Step 1: Infos Générales
#   with_options if: -> { step.present? && Event.steps[step] >= 1 } do
#     validates :name, :description, :cover_image, :category, presence: true
#   end

#   # Step 2: Dates Heures
#   with_options if: -> { step.present? && Event.steps[step] >= 2 } do
#     validates :start_at, :end_at, presence: true
#     validate :end_after_start
#   end

#   # Step 3: Lieu
#   with_options if: -> { step.present? && Event.steps[step] >= 3 } do
#     validates :venue, presence: true
#     validates_associated :venue
#   end

#   # Step 4: Billets
#   with_options if: -> { step.present? && Event.steps[step] >= 4 } do
#     validates :ticket_types, presence: true
#     validates_associated :ticket_types
#   end

#   # Step 5: Visibilité
#   with_options if: -> { step.present? && Event.steps[step] >= 5 } do
#     validates :status, :access_visibility, :entry_requirement, presence: true
#   end

#   # Scopes
#   scope :past, -> { where("end_at < ?", Time.current) }
#   scope :future, -> { where("start_at > ?", Time.current) }

#   # Instance methods
#   def past?
#     end_at.present? && end_at < Time.current
#   end

#   def future?
#     start_at.present? && start_at > Time.current
#   end

#   def previous_step
#     i = Event.steps[step] - 1
#     i if Event.steps.values.include?(i)
#   end

#   def next_step
#     i = Event.steps[step] + 1
#     i if Event.steps.values.include?(i)
#   end

#   def last_step?
#     step_before_type_cast == Event.steps.values.max
#   end

#   def first_step?
#     step_before_type_cast == Event.steps.values.min
#   end

#   # Private methods
#   private

#   def generate_public_reference
#     loop do
#       ref = "#{('A'..'Z').to_a.sample}#{rand(1000..9999)}"
#       unless self.class.exists?(public_reference: ref)
#         self.public_reference = ref
#         break
#       end
#     end
#   end

#   # Custom validators
#   def end_after_start
#     return if end_at.blank? || start_at.blank?
#     if end_at < start_at
#       errors.add(:end_at, "doit être après la date de début")
#     end
#   end
# end
