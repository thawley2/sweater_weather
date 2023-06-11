FactoryBot.define do
  factory :user do
    email { Faker::Internet.email(name: Faker::Name.name, separators: ['-']) }
    password { Faker::Internet.password }
    api_key { SecureRandom.hex(13) }
  end
end