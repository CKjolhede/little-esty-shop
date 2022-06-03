class Merchant < ApplicationRecord

  has_many :items, dependent: :destroy

  validates_presence_of :name

  def items_to_ship
    items.joins(:invoice_items).select("items.name, invoice_items.invoice_id").where.not("invoice_items.status = 'Shipped'")
  end

  def indiv_invoice_ids
    InvoiceItem.all.where(item_id: items.ids).pluck(:invoice_id).uniq
  end
end
