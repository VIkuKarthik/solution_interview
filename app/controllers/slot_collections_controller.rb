class SlotCollectionsController < ApplicationController
  before_action :set_slot_collection, only: %i[ show update destroy ]

  # GET /slot_collections
  def index
    @slot_collections = SlotCollection.all

    render json: @slot_collections
  end

  # GET /slot_collections/1
  def show
    render json: @slot_collection
  end

  # POST /slot_collections
  def create
    @slot_collection = SlotCollection.new(slot_collection_params)

    if @slot_collection.save
      render json: @slot_collection, status: :created, location: @slot_collection
    else
      render json: @slot_collection.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /slot_collections/1
  def update
    if @slot_collection.update(slot_collection_params)
      render json: @slot_collection
    else
      render json: @slot_collection.errors, status: :unprocessable_entity
    end
  end

  # DELETE /slot_collections/1
  def destroy
    @slot_collection.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slot_collection
      @slot_collection = SlotCollection.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def slot_collection_params
      params.require(:slot_collection).permit(:slot_id, :start_time, :end_time, :capacity)
    end
end
