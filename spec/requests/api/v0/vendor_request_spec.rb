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
        error = JSON.parse(response.body, symbolize_names: true)

        expect(error[:errors]).to eq("Couldn't find Vendor with 'id'=11251")

    end

    it 'Can create a vendor from a POST request' do

        body =  {
            "name": "Buzzy Bees",
            "description": "local honey and wax products",
            "contact_name": "Berly Couwer",
            "contact_phone": "8389928383",
            "credit_accepted": false
        }

        post api_v0_vendors_path(body)
        
        expect(response).to have_http_status(201)

        vendor = Vendor.first

        expect(vendor.name).to eq("Buzzy Bees")
        expect(vendor.description).to eq("local honey and wax products")
        expect(vendor.contact_name).to eq("Berly Couwer")
        expect(vendor.contact_phone).to eq("8389928383")
        expect(vendor.credit_accepted).to eq(false)
    end

    it 'returns status 400 when all fields not included' do

        body =  {
            "name": "Buzzy Bees",
            "description": "local honey and wax products",
            "credit_accepted": false
        }

        post api_v0_vendors_path(body)
        
        expect(response).to have_http_status(400)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error[:errors]).to eq("Validation failed: Contact name can't be blank, Contact phone can't be blank")
    end

    it 'can delete a vendor' do

        create(:vendor)
        vendor = Vendor.first

        expect(vendor).to be_a(Vendor)

        delete api_v0_vendor_path(vendor)

        expect(response).to have_http_status(204)

        expect(Vendor.all).to eq([])
    end

    it 'returns status 404 if trying to delete a missing vendor' do
        delete api_v0_vendor_path(123123123123)

        expect(response).to have_http_status(404)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error[:errors]).to eq("Couldn't find Vendor with 'id'=123123123123")
    end

    it 'can update an existing vendor' do
        body =  {
            "name": "Buzzy Bees",
            "description": "local honey and wax products",
            "contact_name": "Berly Couwer",
            "contact_phone": "8389928383",
            "credit_accepted": false
        }

        update_body =  {
            "name": "All Tails Wag",
            "description": "Animal Shelter",
        }

        post api_v0_vendors_path(body)
        
        expect(response).to have_http_status(201)

        vendor = Vendor.first

        expect(vendor.name).to eq("Buzzy Bees")
        expect(vendor.description).to eq("local honey and wax products")
        expect(vendor.contact_name).to eq("Berly Couwer")
        expect(vendor.contact_phone).to eq("8389928383")
        expect(vendor.credit_accepted).to eq(false)

        patch api_v0_vendor_path(vendor, update_body)

        vendor = Vendor.first

        expect(vendor.name).to eq("All Tails Wag")
        expect(vendor.description).to eq('Animal Shelter')
        expect(vendor.contact_name).to eq("Berly Couwer")
        expect(vendor.contact_phone).to eq("8389928383")
        expect(vendor.credit_accepted).to eq(false)
    end

    it 'returns status code 404 when updating a non exisant vendor' do

        update_body =  {
            "name": "All Tails Wag",
            "description": "Animal Shelter",
        }

        patch api_v0_vendor_path(121351212)

        expect(response).to have_http_status(404)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error[:errors]).to eq("Couldn't find Vendor with 'id'=121351212")
    end
    it 'returns status code 400 when updating a vendor with empty fields' do

        body =  {
            "name": "Buzzy Bees",
            "description": "local honey and wax products",
            "contact_name": "Berly Couwer",
            "contact_phone": "8389928383",
            "credit_accepted": false
        }

        update_body =  {
            "name": "",
            "description": "Animal Shelter",
        }

        post api_v0_vendors_path(body)
        
        expect(response).to have_http_status(201)

        vendor = Vendor.first

        patch api_v0_vendor_path(vendor, update_body)

        expect(response).to have_http_status(400)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error[:errors]).to eq("Validation failed: Name can't be blank")
    end
end