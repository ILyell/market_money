require 'rails_helper'

RSpec.describe Market, type: :model do

    describe 'initialize' do
        it 'exist' do
            create(:market)

            market = Market.first

            expect(market).to be_a(Market)
        end
    end

    describe 'relations' do
        it { should have_many(:market_vendors) }
        it { should have_many(:vendors).through(:market_vendors) }
    end

    describe "#instance methods" do
        it 'returns a count of vendors associated with this market' do
            create_list(:market, 2)

            market_1 = Market.all[0]
            market_2 = Market.all[1]
            create_list(:vendor, 5)

            market_1.vendors << Vendor.all[0]
            market_1.vendors << Vendor.all[1]
            market_1.vendors << Vendor.all[2]
            market_1.vendors << Vendor.all[3]
            market_2.vendors << Vendor.all[3]
            market_2.vendors << Vendor.all[4]

            expect(market_1.vendor_count).to eq(4)
            expect(market_2.vendor_count).to eq(2)
        end
    end

end