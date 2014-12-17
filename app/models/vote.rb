class Vote < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :person

  validates :proposal, presence: true
  validates :person, presence: true
end
