class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    wrap_parameters format: []

    def index        
        apartments = Apartment.all  
        render json: apartments, include: :tenants
    end

    def show    
        apartment = find_apartment
        render json: apartment, include: :tenants
    end

    def update   
        apartment = find_apartment
        apartment.update!(apartment_params)
        render json: apartment, status: :ok
    end

    def create   
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    def destroy 
        apartment = find_apartment
        apartment.destroy
        head :no_content
    end

    private

    def find_apartment   
        Apartment.find(params[:id])
    end

    def apartment_params
        params.permit(:number)
      end

    def render_not_found_response
      render json: { error: "Apartment not found" }, status: :not_found
    end
  
    def render_unprocessable_entity_response(invalid)  
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
