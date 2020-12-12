FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { Faker::Stripe.valid_card }
    result { "success" }
    credit_card_expiration_date { "" }
  end
end
