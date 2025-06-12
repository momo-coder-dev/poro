class Venue < ApplicationRecord
  #  REVOIR LE RELATIONSHIP
  #  Un événement peut avoir plusieurs lieux
  #  UN LIEU PEUT AVOIR EUT PLUSIEURS ÉVÉNEMENTS
  # has_many :events
  belongs_to :event

  validates :name, presence: true
  validates :address, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true

  # with_options if: -> { new_record? && event.present? && Event.steps[event.step] >= 3 } do
  #   validates :name, presence: true
  #   validates :address, presence: true
  #   validates :longitude, presence: true
  #   validates :latitude, presence: true
  # end
  #


  def gps_coordinates
    "Longitude: #{longitude}, Latitude: #{latitude}"
  end
end
