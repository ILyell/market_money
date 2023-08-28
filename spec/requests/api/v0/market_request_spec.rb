require 'rails_helper'

describe Market, type: :request do
    it 'sends a list of markets' do
        create_list(:market, 3)

        get api_v0_markets_path

        expect(response).to be_successful

        markets = JSON.parse(response.body, symbolize_names: true) 

        expect(markets).to have_key(:data)
        expect(markets[:data]).to be_a(Array)
        expect(markets[:data].count).to eq(3)

        markets[:data].each do |market|
            expect(market).to have_key(:id)
            expect(market[:id]).to be_an(String)

            expect(market).to have_key(:type)
            expect(market[:type]).to be_an(String)

            expect(market).to have_key(:attributes)
            expect(market[:attributes]).to be_an(Hash)

            expect(market[:attributes]).to have_key(:name)
            expect(market[:attributes][:name]).to be_an(String)

            expect(market[:attributes]).to have_key(:street)
            expect(market[:attributes][:street]).to be_an(String)

            expect(market[:attributes]).to have_key(:city)
            expect(market[:attributes][:city]).to be_an(String)

            expect(market[:attributes]).to have_key(:county)
            expect(market[:attributes][:county]).to be_an(String)

            expect(market[:attributes]).to have_key(:state)
            expect(market[:attributes][:state]).to be_an(String)

            expect(market[:attributes]).to have_key(:zip)
            expect(market[:attributes][:zip]).to be_an(String)

            expect(market[:attributes]).to have_key(:lat)
            expect(market[:attributes][:lat]).to be_an(String)

            expect(market[:attributes]).to have_key(:lon)
            expect(market[:attributes][:lon]).to be_an(String)

            # expect(market[:attributes]).to have_key(:vender_count)
            # expect(market[:attributes][:vender_count]).to be_an(Integer)

        end
    end

    it 'Can get one market by its id' do

        id = create(:market).id

        get api_v0_market_path(id)

        markets = JSON.parse(response.body, symbolize_names: true) 

        expect(markets).to have_key(:data)
        expect(markets[:data]).to be_a(Hash)

        market = markets[:data]
        expect(market).to have_key(:id)
        expect(market[:id]).to be_an(String)

        expect(market).to have_key(:type)
        expect(market[:type]).to be_an(String)

        expect(market).to have_key(:attributes)
        expect(market[:attributes]).to be_an(Hash)

        expect(market[:attributes]).to have_key(:name)
        expect(market[:attributes][:name]).to be_an(String)

        expect(market[:attributes]).to have_key(:street)
        expect(market[:attributes][:street]).to be_an(String)

        expect(market[:attributes]).to have_key(:city)
        expect(market[:attributes][:city]).to be_an(String)

        expect(market[:attributes]).to have_key(:county)
        expect(market[:attributes][:county]).to be_an(String)

        expect(market[:attributes]).to have_key(:state)
        expect(market[:attributes][:state]).to be_an(String)

        expect(market[:attributes]).to have_key(:zip)
        expect(market[:attributes][:zip]).to be_an(String)

        expect(market[:attributes]).to have_key(:lat)
        expect(market[:attributes][:lat]).to be_an(String)

        expect(market[:attributes]).to have_key(:lon)
        expect(market[:attributes][:lon]).to be_an(String)

        # expect(market[:attributes]).to have_key(:vender_count)
        # expect(market[:attributes][:vender_count]).to be_an(Integer)
    end
end