class Slot < ApplicationRecord
  has_many :slot_collections, dependent: :destroy

  validates :total_capacity, numericality: { only_integer: true }
end
