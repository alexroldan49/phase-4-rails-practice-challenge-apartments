class TenantsController < ApplicationController

    def index
        render json: Tenant.all
    end

    def show
        tenant = Tenant.find_by(id: params[:id])
        if tenant
            render json: tenant, status: :ok
        else
            render_not_found
        end
    end

    def update
        tenant = Tenant.find_by(id: params[:id])
        if tenant
            tenant.update(tenant_params)
            render json: tenant, status: :ok
        else
            render_not_found
        end
    end

    def create
        tenant = Tenant.new(tenant_params)
        if tenant.save
            render json: tenant, status: :created
        else
            render json: {errors: tenant.errors.full_messages}
        end
    end

    def destroy
        tenant = Tenant.find_by(id: params[:id])
        if tenant
            tenant.destroy
            render json: {}, status: :ok
        else
            render_not_found
        end
    end


    private

    def render_not_found
        render json: {errors: "Tenant not found"}, status: :not_found
    end

    def tenant_params
        params.permit(:name, :age)
    end
    
end
