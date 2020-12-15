FactoryBot.define do
  factory :transaction do
    credit_card_number { "4580251236515201" }
    credit_card_expiration_date { "04/23" }
    result { "success" }
    invoice
  end
end
