FactoryBot.define do

  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    # email                 {"kkk@gmail.com"}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    sequence (:email){Faker::Internet.email}
  end

end