class Market < ApplicationRecord
    has_many :market_vendors
    has_many :vendors, through: :market_vendors

    validates :name, presence: true
    validates :street, presence: true
    validates :city, presence: true
    validates :state, presence: true
    validates :zip, presence: true
    validates :lat, presence: true
    validates :lon, presence: true
    validates :vendor_count, presence: true


    def vendor_count
        self.vendors.count
    end
end