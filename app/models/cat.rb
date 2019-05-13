class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  COLORS = %w(black white orange brown)

  validates :name, :description, :birth_date, presence: true
  validates :color, presence: true, inclusion: { in: COLORS, message: "%{value} is not a valid color" } 
  validates :sex, presence: true, inclusion: { in: %w(M F), message: "%{value} is not a valid sex (M or F)" }

  has_many :rental_requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :CatRentalRequest,
    dependent: :destroy

  def age
    time_ago_in_words(birth_date)
  end
end
