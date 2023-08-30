class MarketVendor < ApplicationRecord
    belongs_to :vendor
    belongs_to :market

    validates :market_id, presence: true
    validates :vendor_id, presence: true
    validates :market_id, uniqueness: { scope: :vendor_id }
end
