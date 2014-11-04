# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "user@localfavorite.me"
    username "LocalFavoriteMe"
    automatic_favoriting false
    uid "uid_abc123"
    provider "twitter"
  end
end
