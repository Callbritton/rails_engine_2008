FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { "MyString" }
    result { "MyString" }
    credit_card_expiration_date { "MyString" }
  end
end
