class TenantsController < ApplicationController
    
    def index
        tenants = Tenant.all
        render json: tenants, status: :ok
    end

    def show
        tenant = find_tenant
        render json: apartment, status: :ok
    end

    def create  
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: created
    end

    def destroy  
        tenant = find_tenant
        tenant.destroy
        head :no_content
    end

    def update  
        tenant = find_tenant
        tenant = Tenant.update!(tenant_params)
        render json: tenant, status: accepted
    end

    private

    def find_tenant
        Tenant.find(params[:id])
    end

    def tenant_params 
        params.permit(:number)
    end
end
