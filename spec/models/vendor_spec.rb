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

  describe 'validations' do
    it 'validates' do
      validate_presence_of :name
      validate_presence_of :description
      validate_presence_of :contact_name
      validate_presence_of :contact_phone
      validate_inclusion_of(:credit_accepted).in_array([true, false])
    end
  end
end
