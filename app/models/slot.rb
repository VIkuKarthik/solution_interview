class Slot < ApplicationRecord
  TIME_INTERVAL = 15
  
  has_many :slot_collections, dependent: :destroy

  validates :total_capacity, numericality: { only_integer: true }
end
