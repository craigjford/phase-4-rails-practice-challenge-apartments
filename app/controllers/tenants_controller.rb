class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    wrap_parameters format: []

    def index        
        tenants = Tenant.all  
        render json: tenants, include: :apartments
    end

    def show    
        tenant = find_tenant
        render json: tenant, include: :apartments
    end

    def update   
        tenant = find_tenant
        tenant.update!(tenant_params)
        render json: tenant, status: :ok
    end

    def create   
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def destroy 
        if params[:lease_id].present? 
            lease = Lease.find_by(id: params[:lease_id], tenant_id: params[:id])
            if lease
                lease.destroy
                # head :no-content
                render json: { status: :ok }
            else
                render json: { error: "Lease not found" }, status: :not_found    
            end
        else
            tenant = find_tenant
            tenant.destroy
            head :no_content
        end
    end

    private

    def find_tenant  
        Tenant.find(params[:id])
    end

    def tenant_params
        params.permit(:name, :age)
      end

    def render_not_found_response
      render json: { error: "Tenant not found" }, status: :not_found
    end
  
    def render_unprocessable_entity_response(invalid)  
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
