require 'rails_helper' 

RSpec.describe MarketVendor, type: :request do
    describe 'Market Vendor CRUD' do
        it 'can create a MarketVendor from an api call' do
            create(:market)
            create(:vendor)

            market = Market.first
            vendor = Vendor.first
            
            expect(market.vendors).to eq([])

            post "/api/v0/market_vendors/?vendor_id=#{vendor.id}&market_id=#{market.id}"
            
            market.reload

            expect(response).to have_http_status(201)

            # expect(response.body).to eq("Successfully added vendor to market")

            expect(market.vendors).to eq([vendor])  

            get api_v0_market_vendors_path(market)

            vendors = JSON.parse(response.body, symbolize_names: true) 
    
            expect(vendors).to have_key(:data)
            expect(vendors[:data].count).to eq(1)
            
        end

        it 'returns status 404 if market_id or vendor_id isnt a valid id' do
            create(:market)
            create(:vendor)

            market = Market.first
            vendor = Vendor.first
            
            post "/api/v0/market_vendors/?vendor_id=#{vendor.id}&market_id=#{121542}"
            
            expect(response).to have_http_status(404)

            post "/api/v0/market_vendors/?vendor_id=#{32154}&market_id=#{market.id}"

            expect(response).to have_http_status(404)

            expect(MarketVendor.all).to eq([])
        end

        it 'returns status 422 if the market_vendor already exist' do
            create(:market)
            create(:vendor)

            market = Market.first
            vendor = Vendor.first
            
            expect(market.vendors).to eq([])

            post "/api/v0/market_vendors/?vendor_id=#{vendor.id}&market_id=#{market.id}"
            
            market.reload

            expect(response).to have_http_status(201)

            post "/api/v0/market_vendors/?vendor_id=#{vendor.id}&market_id=#{market.id}"

            expect(response).to have_http_status(422)


        end

        it 'can delete a market vendor from an api call' do
            create(:market)
            create(:vendor)

            market = Market.first
            vendor = Vendor.first

            create(:market_vendor, market_id: market.id, vendor_id: vendor.id)

            market_vendor = MarketVendor.first

            expect(market_vendor).to be_a(MarketVendor)

            delete "/api/v0/market_vendors/?vendor_id=#{vendor.id}&market_id=#{market.id}"

            expect(response).to have_http_status(204)


            expect(MarketVendor.all).to eq([])

        end


        it 'returns status 404 if no market vendor exist with that vendor_id and market_id' do

            delete "/api/v0/market_vendors/?vendor_id=#{12}&market_id=#{12}"

            expect(response).to have_http_status(404)

            error = JSON.parse(response.body, symbolize_names: true)

        end
    end
end