FactoryBot.define do
  factory :customer do
    first_name { Faker::TvShows::StarTrek.character }
    last_name { Faker::TvShows::StarTrek.location }
  end
end
