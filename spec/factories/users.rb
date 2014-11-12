# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "user@localfavorite.me"
    username "LocalFavoriteMe"
    uid "uid_abc123"
    provider "twitter"
  end
end
