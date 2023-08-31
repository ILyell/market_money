require 'rails_helper' 

RSpec.describe MarketVendor, type: :request do
    before(:each) do
        @headers = {"CONTENT_TYPE" => "application/json"}
        create(:market)
        create(:vendor)

        @market = Market.first
        @vendor = Vendor.first

    end
    describe 'Market Vendor CRUD' do
        it 'can create a MarketVendor from an api call' do

        body = {
            "market_id": "#{@market.id}",
            "vendor_id": "#{@vendor.id}"
        }
        
            expect(@market.vendors).to eq([])

            post api_v0_join_table_market_vendors_path, headers: @headers, params: JSON.generate(body)
            
            @market.reload

            expect(response).to have_http_status(201)

            # expect(response.body).to eq("Successfully added vendor to market")

            expect(@market.vendors).to eq([@vendor])  

            get api_v0_market_vendors_path(@market)

            vendors = JSON.parse(response.body, symbolize_names: true) 

            expect(vendors).to have_key(:data)
            expect(vendors[:data].count).to eq(1)
            
        end

        it 'returns status 404 if market_id or vendor_id isnt a valid id' do

            body_1 = {
                "market_id": "1223213",
                "vendor_id": "#{@vendor.id}"
            }

            body_2 = {
                "market_id": "#{@market.id}",
                "vendor_id": "12312443"
            }
            
            post api_v0_join_table_market_vendors_path, headers: @headers, params: JSON.generate(body_1)

            
            expect(response).to have_http_status(404)

            post api_v0_join_table_market_vendors_path, headers: @headers, params: JSON.generate(body_2)

            expect(response).to have_http_status(404)

            expect(MarketVendor.all).to eq([])
        end

        it 'returns status 422 if the market_vendor already exist' do

            body = {
                "market_id": "#{@market.id}",
                "vendor_id": "#{@vendor.id}"
            }
            
            expect(@market.vendors).to eq([])

            post api_v0_join_table_market_vendors_path, headers: @headers, params: JSON.generate(body)
            
            @market.reload

            expect(response).to have_http_status(201)

            post api_v0_join_table_market_vendors_path, headers: @headers, params: JSON.generate(body)

            expect(response).to have_http_status(422)


        end

        it 'can delete a market vendor from an api call' do

            body = {
                "market_id": "#{@market.id}",
                "vendor_id": "#{@vendor.id}"
            }
            
            create(:market_vendor, market_id: @market.id, vendor_id: @vendor.id)

            market_vendor = MarketVendor.first
            # binding.pry
            expect(market_vendor).to be_a(MarketVendor)

            delete api_v0_join_table_market_vendors_path, headers: @headers, params: JSON.generate(body)

            expect(response).to have_http_status(204)


            expect(MarketVendor.all).to eq([])

        end


        it 'returns status 404 if no market vendor exist with that vendor_id and market_id' do

            body = {
                "market_id": "#{@market.id}",
                "vendor_id": "#{@vendor.id}"
            }

            delete api_v0_join_table_market_vendors_path, headers: @headers, params: JSON.generate(body)

            expect(response).to have_http_status(404)

            error = JSON.parse(response.body, symbolize_names: true)

        end
    end
end