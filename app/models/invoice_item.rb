class InvoiceItem < ApplicationRecord
  belongs_to :item 
  belongs_to :invoice

  validates_presence_of :item_id, 
                        :invoice_id,
                        :quantity,
                        :unit_price
end