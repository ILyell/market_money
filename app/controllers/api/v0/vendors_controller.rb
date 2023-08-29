class Api::V0::VendorsController < ApplicationController
    def show
        begin
            render json: VendorSerializer.new(Vendor.find(params[:id]))
        rescue ActiveRecord::RecordNotFound => e
            render :json => { errors: e.message }, status: :not_found 
        end
    end

    def index
        begin
            render json: VendorSerializer.new(Market.find(params[:market_id]).vendors)
        rescue ActiveRecord::RecordNotFound => e
            render :json => { errors: e.message }, status: :not_found 
        end
    end

    def create
        begin
            render json: VendorSerializer.new(Vendor.create!(create_params)), status: :created
        rescue ActiveRecord::RecordInvalid => e
            render :json => { errors: e.message }, status: :bad_request
        end
    end

    def destroy
        begin
            Vendor.destroy(params[:id])
        rescue ActiveRecord::RecordNotFound => e
            render :json => { errors: e.message }, status: :not_found 
        end
    end

    private

    def create_params
        params.permit(:contact_name, :contact_phone, :description, :name, :credit_accepted)
    end
end