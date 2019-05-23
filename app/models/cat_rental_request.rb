class CatRentalRequest < ApplicationRecord
  validates :start_date, :end_date, presence: true
  validates :status, presence: true, inclusion: { in: %w(PENDING APPROVED DENIED), message: "%{value} is not a valid status" }
  validate :does_not_overlap_approved_request
  validate :no_past_rental_dates
  validate :start_before_end

  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :Cat

  belongs_to :requester,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  after_initialize :assign_pending_status

  def approved?
    self.status == 'APPROVED'
  end

  def denied?
    self.status == 'DENIED'
  end

  def pending?
    self.status == 'PENDING'
  end

  def approve!
    raise 'not pending' unless self.pending?
    transaction do
      self.status = 'APPROVED'
      self.save!

      self.overlapping_pending_requests.each do |req|
        req.update!(status: 'DENIED')
      end
    end
  end

  def deny!
    raise 'not pending' unless self.pending?

    self.status = 'DENIED'
    self.save!
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: 'PENDING')
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  def does_not_overlap_approved_request
    unless self.denied? || overlapping_approved_requests.empty?
      errors[:base] << 'Request conflicts with existing approved requests'
    end
  end

  private

  def assign_pending_status
    self.status ||= 'PENDING'
  end

  def overlapping_requests
    CatRentalRequest
      .where.not(id: self.id)
      .where(cat_id: self.cat_id)
      .where.not('start_date > :end_date OR end_date < :start_date',
        start_date: self.start_date, end_date: self.end_date)
  end

  def start_before_end
    errors[:start_date] << 'must come before end date' if self.start_date > self.end_date
  end

  def no_past_rental_dates
    errors[:start_date] << 'must not be in the past' if self.start_date < Time.now
    errors[:end_date] << 'must not be in the past' if self.end_date < Time.now
  end
end
