class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  CAT_COLORS = %w(black white orange brown)

  validates :name, :description, :birth_date, presence: true
  validates :color, presence: true, inclusion: { in: CAT_COLORS, message: "%{value} is not a valid color" } 
  validates :sex, presence: true, inclusion: { in: %w(M F), message: "%{value} is not a valid sex (M or F)" }

  def age
    time_ago_in_words(birth_date)
  end
end
