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
    capacity_stack = capacity_calculation

    begin
      prev_time = start_time
      start_time += Slot::TIME_INTERVAL.minutes

      slot.slot_collections.create(
        start_time: prev_time,
        end_time: start_time,
        capacity: capacity_stack.shift
      )
    end while start_time < end_time

    slot.slot_collections
  end

  def capacity_calculation
    slot_duration = Slot::TIME_INTERVAL
    capacity = slot.total_capacity
    total_minutes = (slot.end_time - slot.start_time)/60
    collection_count = (total_minutes/slot_duration).to_i
    capacity_divded = slot.total_capacity.to_f/collection_count.to_f
    integer_capacity, fraction_capacity = capacity_divded.to_s.split(".").map(&:to_i)

    stack = [0]*collection_count

    integer_capacity.times do
      (collection_count).times do |counter|
        stack[counter] += 1
        capacity -= 1
      end
    end
    
    if fraction_capacity > 0
      (0..collection_count-1).to_a.reverse.each do |counter|
        if capacity>0
          stack[counter] += 1
          capacity -= 1
        end
      end
    end

    stack
  end

end