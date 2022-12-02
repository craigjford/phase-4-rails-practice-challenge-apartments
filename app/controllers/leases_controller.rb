class LeasesController < ApplicationController
    
    def create
        lease = lease.create!(lease_params)
        render json: lease, status: :created
    end

    def destroy
        lease = find_lease
        lease.destroy
        head :no_content
    end

    private

    def find_lease
        Lease.find(params[:id])
    end

    def lease_params
        params.permit(:apartment_id, :tenants_id, :rent)
    end

end
