class ScientistsController < ApplicationController
    before_action :set_scientist, only: [:show, :update, :destroy]
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        scientists = Scientist.all
        render json: scientists
    end

    def show
        render json: @scientist
    end

    def create
        scientist = Scientist.create!(scientist_params)
        render json: scientist, status: :created
    end

    def update
        @scientist.update!(scientist_params)
        render json: @scientist, status: :accepted
    end

    def destroy
        @scientist.destroy
        head :no_content
    end

    private

    def set_scientist
        @scientist = Scientist.find(params[:id])
    end

    def scientist_params
        params.require(:scientist).permit(:name, :field_of_study, :avatar)
    end

    def record_not_found
        render json: { error: "Scientist not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
