class Proposal < ActiveRecord::Base
  belongs_to :conference
  belongs_to :person
  has_many :votes

  validates :conference, presence: true
  validates :person, presence: true
  validates :title, presence: true
  validates :summary, presence: true

  scope :with_person, -> { includes :person }
end
