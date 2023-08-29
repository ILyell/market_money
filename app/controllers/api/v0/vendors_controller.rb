class Api::V0::VendorsController < ApplicationController
    def show
        
    end

    def index
        begin
            render json: VendorSerializer.new(Market.find(params[:market_id]).vendors)
        rescue ActiveRecord::RecordNotFound => e
            render :json => { errors: e.message }, status: :not_found 
        end
    end
end