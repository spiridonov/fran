class Workout < ActiveRecord::Base

  has_many :users, through: :user_workouts
  has_many :user_workouts, dependent: :destroy
  belongs_to :box
  
end
