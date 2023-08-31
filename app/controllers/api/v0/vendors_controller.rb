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
            render json: VendorSerializer.new(Vendor.create!(vendor_params)), status: :created
        rescue ActiveRecord::RecordInvalid => e
            render :json => { errors: e.message }, status: :bad_request
        end
    end

    def destroy
        begin
            Vendor.find(params[:id]).destroy
        rescue ActiveRecord::RecordNotFound => e
            render :json => { errors: e.message }, status: :not_found 
        end
    end

    def update
        begin
            vendor = Vendor.find(params[:id])
            vendor.update!(vendor_params)
            render json: VendorSerializer.new(vendor)
        rescue ActiveRecord::RecordNotFound => e
            render :json => { errors: e.message }, status: :not_found 
        rescue ActiveRecord::RecordInvalid => e
            render :json => { errors: e.message }, status: :bad_request
        end
    end

    private

    def vendor_params
        params.require(:vendor).permit(:contact_name, :contact_phone, :description, :name, :credit_accepted)
    end
end