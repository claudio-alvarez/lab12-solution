class Event < ApplicationRecord
  belongs_to :event_venue, optional: true
  has_one :event_stat
  has_many :ticket_types
  has_one_attached :flyer
  accepts_nested_attributes_for :ticket_types, allow_destroy: true
  accepts_nested_attributes_for :event_venue

  validates :name, :description, presence: true
  validates :start_date, not_in_past: true
  validates :event_venue, presence: true
end


