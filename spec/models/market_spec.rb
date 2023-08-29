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

end