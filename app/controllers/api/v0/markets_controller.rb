class Api::V0::MarketsController < ApplicationController
    def index 
        render json: MarketSerializer.new(Market.all)
    end

    def show
        begin
            render json: MarketSerializer.new(Market.find(params[:id]))
        rescue ActiveRecord::RecordNotFound => e
            render :json => { errors: e.message }, status: :not_found 
        end
    end
end