class Vote < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :person

  validates :person, presence: true
  validates :proposal, presence: true, uniqueness: { scope: :person }
end
