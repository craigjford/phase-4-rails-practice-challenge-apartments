class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def create 
        lease = Lease.create(lease_params)
        render json: lease, status: :created
    end

    private

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end
  
    def render_unprocessable_entity_response(invalid)  
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
