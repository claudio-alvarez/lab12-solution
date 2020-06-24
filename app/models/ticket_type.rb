class TicketType < ApplicationRecord
  belongs_to :event
  has_many :tickets

  validates :description, presence: true
  validates :ticket_price, numericality: { only_integer: true }

end


