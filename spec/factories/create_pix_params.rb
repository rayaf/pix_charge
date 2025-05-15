FactoryBot.define do
  factory :create_pix_params, class: Hash do
    payer do
      {
        name: 'Stella Isabelle',
        document_number: '585.853.868-19',
        address: {
          zip_code: '68902-020',
          street: 'Rua Leopoldo Machado',
          number: '216',
          complement: 'casa',
          neighborhood: 'Beirol',
          city_name: 'Macapá',
          state: 'AP'
        }
      }
    end

    fine_type { 1 }
    reduction_type { 0 }
    interest_type { 0 }
    tags { ['tag-1'] }
    amount { Faker::Number.between(from: 1000, to: 5000) }
    pix_account_id { 278 }
    expire_at { (DateTime.now+2).iso8601 }
    fine_percentage { "5,00" }
    fine_amount { "50,00" }
    reduction_amount { "25,00" }
    reduction_percentage { "2,50" }
    interest_amount { "20,00" }
    interest_percentage { "2,50" }
    virtual_pix_id { 1 }
    message { Faker::Lorem.sentence }
    financial_provider_external_id { "fp_#{SecureRandom.hex(4)}" }

    initialize_with do
      attributes.stringify_keys
    end
  end
end
