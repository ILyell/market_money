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

    def search
        valid_search_params
    end

    private 

    def valid_search_params
        if params.key?("city") == true && params.key?("name") == true && params.key?("state") == false
            render :json => { errors: "Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint." }, status: 422
        elsif params.key?("city") == false && params.key?("name") == true && params.key?("state") == false
            render :json => { errors: "Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint." }, status: 422
        else
            render :json => MarketSerializer.new(Market.where("name LIKE ?", "%#{params[:name]}%") && Market.where("city LIKE ?", "%#{params[:city]}%") && Market.where("state LIKE ?", "%#{params[:state]}%")), status: 201
        end
    end
end