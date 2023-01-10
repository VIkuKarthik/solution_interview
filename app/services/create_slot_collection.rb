class CreateSlotCollection < ApplicationService

  def initialize(slot)
    @slot = slot
    @prev_time = slot.start_time
  end

  def call
    slot_collections
  end

  private

  attr_accessor :slot, :prev_time

  def slot_collections
    start_time = slot.start_time
    end_time = slot.end_time
    times = []
    capacity = 1

    begin
      prev_time = start_time
      start_time += 15.minutes
      times << "#{prev_time.strftime('%H:%M')} - #{start_time.strftime('%H:%M')} | collection: "
      
      slot.slot_collections.create(
        start_time: prev_time,
        end_time: start_time,
        capacity: 1
      )
    end while start_time < end_time
    slot.slot_collections
  end

end