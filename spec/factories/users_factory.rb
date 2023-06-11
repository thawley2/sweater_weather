FactoryBot.define do
  factory :user do
    email { Faker::Internet.email(name: name, separators: ['-']) }
    password { Faker::Internet.password }
    api_key { SecureRandom.hex(13) }
  end
end