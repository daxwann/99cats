class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  COLORS = %w(black white orange brown)

  validates :name, :description, :birth_date, :user_id, presence: true
  validates :color, presence: true, inclusion: { in: COLORS, message: "%{value} is not a valid color" } 
  validates :sex, presence: true, inclusion: { in: %w(M F), message: "%{value} is not a valid sex (M or F)" }
  validate :birth_date_in_the_past, if: -> { self.birth_date }

  has_many :requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :CatRentalRequest,
    dependent: :destroy

  belongs_to :owner,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  def age
    time_ago_in_words(self.birth_date)
  end

  private

  def birth_date_in_the_past
    if self.birth_date && self.birth_date > Time.now
      errors[:birth_date] << 'must be in the past'
    end
  end
end
