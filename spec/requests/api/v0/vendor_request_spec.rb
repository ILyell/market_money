require 'rails_helper'

RSpec.describe Vendor, type: :request do
    it 'sends a vendor from an id' do
        create(:vendor)
        vendor = Vendor.first

        get api_v0_vendor_path(vendor)

        vendors = JSON.parse(response.body, symbolize_names: true) 

        expect(vendors).to have_key(:data)

        vendor = vendors[:data]

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

    it 'Returns an error when there is no market with that id for returning vendors' do
        
        get api_v0_vendor_path(11251)

        expect(response).to have_http_status(404)

    end
end