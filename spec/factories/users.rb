FactoryBot.define do
  factory :user do
    nickname              { 'testuser' }
    email                 { Faker::Internet.unique.email }
    password              { 'a1a1a1' }
    password_confirmation { password }
    last_name             { '山田' }
    first_name            { '太郎' }
    last_name_kana        { 'ヤマダ' }
    first_name_kana       { 'タロウ' }
    birthday              { Date.new(1990, 1, 1) }
  end
end
