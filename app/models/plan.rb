class Plan < ActiveRecord::Base
  # name, description, amount, stripe_plan_id
  has_many :user_plans
end
