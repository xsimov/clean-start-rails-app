class Transaction < ApplicationRecord
  CURRENCY_SYMBOLS = {
    eur: '€'
  }

  enum currency: { eur: 0 }

  validates :title, :purchased_on, :value, :producer_id, presence: true

  def formatted_currency
    CURRENCY_SYMBOLS[currency.to_sym]
  end
end
