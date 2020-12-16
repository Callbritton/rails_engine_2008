class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  def self.attribute_filter(attribute, value)
    if attribute == "created_at" || attribute == "updated_at"
      find_by("#{attribute} = #{value}").first
    elsif attribute == "unit_price"
      find_by("#{attribute} = #{value.to_f}")
    else
      where("#{attribute} ILIKE ?", "%#{value}%").first
    end
  end
end
