class ApartmentsController < ApplicationController

    def index
        apartments = Apartment.all
        render json: apartments
    end

    def show
        apartment = Apartment.find_by(id: params[:id])
        if apartment
            render json: apartment, status: :ok
        else
           render_not_found
        end
    end

    def update
        apartment = Apartment.find_by(id: params[:id])
        if apartment
            apartment.update(apartment_params)
            render json: apartment
        else
            render_not_found
        end
    end

    def create
        apartment = Apartment.new(apartment_params)
        if apartment.save
            render json: apartment, status: :created
        else
            render json: {errors: apartment.errors.full_messages}
        end
    end

    def destroy
        apartment = Apartment.find_by(id: params[:id])
        if apartment
            apartment.destroy
            render json: {}, status: :ok
        else
            render_not_found
        end
    end
    

    private

    def apartment_params
        params.permit(:number)
    end
    
    def render_not_found
        render json: {errors: "apartment not found"}, status: :not_found
    end
end
