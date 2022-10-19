class MissionsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def create
        mission = Mission.create!(mission_params)
        render json: mission.planet, status: 201
    end

    private

    def mission_params
        params.require(:mission).permit(:name, :scientist_id, :planet_id)
    end

    def record_not_found
        render json: { error: "Scientist not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
