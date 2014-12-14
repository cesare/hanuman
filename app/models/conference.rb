class Conference < ActiveRecord::Base
  include AASM

  has_many :proposals
  has_many :staffs

  validates :name, presence: true
  validates :description, presence: true
  validates :begins_at, presence: true
  validates :ends_at, presence: true
  validates :proposal_deadline, presence: true

  enum state: {
    draft: 0,
    open_to_proposals: 10,
    deciding: 20,
    settled: 30,
  }

  aasm column: :state, enum: true do
    state :draft, initial: true
    state :open_to_proposals
    state :deciding
    state :settled

    event :open do
      transitions from: :draft, to: :open_to_proposals
    end

    event :close do
      transitions from: :open_to_proposals, to: :deciding
    end

    event :settle do
      transitions from: :deciding, to: :settled
    end
  end
end
