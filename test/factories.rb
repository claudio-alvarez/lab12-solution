require 'securerandom'

include FactoryBot::Syntax::Methods
FactoryBot.define do
  factory :admin do
    
  end

  factory :customer do
    name { Faker::Name.name }
    lastname { Faker::Name.last_name }
    password { '123123123' } #SecureRandom.alphanumeric(8) }
    address { Faker::Address.street_address }
    gender { Faker::Gender.short_binary_type }
    age { rand(18..120) }
    email { "#{name.gsub(/\s+/, "")}.#{lastname.gsub(/\s+/, "")}@example.com".downcase }
    phone { rand(10**9..10**10).to_s }

    factory :customer_with_orders do
      transient do
        orders_count { rand(1..10) }
      end

      after(:create) do |customer, evaluator|
        create_list(:order, evaluator.orders_count, customer: customer)
      end
    end
  end

  factory :event do
    name { Faker::Esport.event }
    description { Faker::ChuckNorris.fact }
    start_date { Faker::Date.between(from: Date.today, to: Date.today + 6.months) }
    event_venue { EventVenue.offset(rand(EventVenue.count)).first }

    factory :event_with_ticket_types_and_tickets do
      transient do
        ticket_types_count { rand(1..5) }
      end

      after(:create) do |event, evaluator|
          create_list(:ticket_type_with_tickets, evaluator.ticket_types_count, event: event)
      end
    end
  end

  factory :event_venue do
    name { Faker::WorldCup.stadium }
    address { Faker::Address.street_address }
    capacity { rand(1..7) * 10000 }
  end

  factory :ticket_type do
    ticket_price { Faker::Number.within(range: 10..100) * 1000 }
    description { Faker::Lorem.sentence }

    factory :ticket_type_with_tickets do
      transient do
        # Create 1000 to 5000 tickets per event
        tickets_count { rand(1..5)*10 }
      end

      after(:create) do |ticket_type, evaluator|
        create_list(:ticket, evaluator.tickets_count, ticket_type: ticket_type)
      end
    end
  end

  factory :ticket do
    ticket_type
    order { Order.offset(rand(Order.count)).first }
  end

  factory :order do
    #customer
  end
end
