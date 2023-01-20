class SlotsController < ApplicationController
  before_action :set_slot, only: %i[ show update destroy ]
  before_action :validate_params, only: %i[ create ]

  # GET /slots
  def index
    @slots = Slot.all

    render json: {success: true, slots: @slots.as_json}
  end

  # GET /slots/1
  def show
    render json: {success: true, slots: @slot.as_json, slot_collections: @slot.slot_collections.as_json}
  end

  # POST /slots
  def create
    @slot = Slot.new(slot_params)

    if @slot.save
      slot_collections = CreateSlotCollection.call(@slot.reload)
      render json: {slot: @slot.as_json, slot_collections: slot_collections.as_json}
    else
      render json: {success: false, message: @slot.errors.full_messages}, status: :unprocessable_entity
    end
  end
  
  # DELETE /slots/1
  def destroy
    @slot.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slot
      @slot = Slot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def slot_params
      params.require(:slot).permit(:start_time, :end_time, :total_capacity)
    end


    def validate_params
      slot = params[:slot]
      if slot[:start_time].scan(/^(2[0-3]|[01]?[0-9]):([0-5]?[0-9])$/).empty? || slot[:end_time].scan(/^(2[0-3]|[01]?[0-9]):([0-5]?[0-9])$/).empty?
        return render json: {success: false, message: "Start / End Time needs to be a HH:MM with 24 hrs format"}
      end
      
      return render json: {success: false, message: "Start Time needs to be future date"} if Time.parse(slot[:start_time]) < Time.zone.now

      return render json: {success: false, message: "End Time should be greated that Start Time"} unless Time.parse(slot[:end_time]) > Time.parse(slot_params[:start_time])
    end

end
