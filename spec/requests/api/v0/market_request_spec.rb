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

            expect(market[:attributes]).to have_key(:vendor_count)
            expect(market[:attributes][:vendor_count]).to be_an(Integer)

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

        expect(market[:attributes]).to have_key(:vendor_count)
        expect(market[:attributes][:vendor_count]).to be_an(Integer)
    end

    it 'Returns an error when there is no market with that id' do
        
        get api_v0_market_path(12345)

        expect(response).to have_http_status(404)

    end

    it 'Returns a list of vendors associated with that market' do
        create(:market)
        market = Market.first
        create_list(:vendor, 3)
        vendors = Vendor.all

        create(:market_vendor, market: market, vendor: vendors[0])
        create(:market_vendor, market: market, vendor: vendors[1])
        create(:market_vendor, market: market, vendor: vendors[2])

        get api_v0_market_vendors_path(market)

        vendors = JSON.parse(response.body, symbolize_names: true) 

        expect(vendors).to have_key(:data)
        expect(vendors[:data].count).to eq(3)

        vendors[:data].each do |vendor|
            expect(vendor).to have_key(:id)
            expect(vendor[:id]).to be_an(String)

            expect(vendor).to have_key(:type)
            expect(vendor[:type]).to be_an(String)

            expect(vendor).to have_key(:attributes)
            expect(vendor[:attributes]).to be_an(Hash)

            expect(vendor[:attributes]).to have_key(:name)
            expect(vendor[:attributes][:name]).to be_an(String)

            expect(vendor[:attributes]).to have_key(:description)
            expect(vendor[:attributes][:description]).to be_an(String)

            expect(vendor[:attributes]).to have_key(:contact_name)
            expect(vendor[:attributes][:contact_name]).to be_an(String)

            expect(vendor[:attributes]).to have_key(:contact_phone)
            expect(vendor[:attributes][:contact_phone]).to be_an(String)

            expect(vendor[:attributes]).to have_key(:credit_accepted)
            expect(vendor[:attributes][:credit_accepted]).to be(true).or be(false)
        end
    end  

    it 'Returns an error when there is no market with that id for returning vendors' do
        
        get api_v0_market_vendors_path(12345)

        expect(response).to have_http_status(404)

    end
end