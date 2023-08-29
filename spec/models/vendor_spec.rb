require 'rails_helper'

RSpec.describe Vendor, type: :model do
    describe 'initialize' do
      it 'exist' do
          create(:vendor)

          vendor = Vendor.first

          expect(vendor).to be_a(Vendor)
      end
    end

    describe 'relations' do
      it { should have_many(:market_vendors) }
      it { should have_many(:markets).through(:market_vendors) }
  end
end
