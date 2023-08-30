class Api::V0::MarketVendorsController < ApplicationController
    def create
        begin
            market = Market.find(create_params[:market_id])
            vendor = Vendor.find(create_params[:vendor_id])
            render json: MarketVendor.create!(create_params), status: :created
        rescue ActiveRecord::RecordInvalid => e
            render :json => { errors: e.message }, status: :unprocessable_entity
        rescue ActiveRecord::RecordNotFound => e
            render :json => { errors: e.message }, status: :not_found
        end
    end

    def destroy
        begin
            mvendor = MarketVendor.find_by!(market_id: create_params[:market_id], vendor_id: create_params[:vendor_id])
            render json: MarketVendor.delete(mvendor), status: :no_content
        rescue ActiveRecord::RecordNotFound => e
            render :json => { errors: e.message }, status: :not_found
        end
    end
    private

    def create_params
        params.permit(:market_id, :vendor_id)
    end
end