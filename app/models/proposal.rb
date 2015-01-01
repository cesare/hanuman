class Proposal < ActiveRecord::Base
  belongs_to :conference
  belongs_to :person
  has_many :votes do
    def by(person)
      find { |vote| vote.person_id == person.id }
    end
  end

  validates :conference, presence: true
  validates :person, presence: true
  validates :title, presence: true
  validates :summary, presence: true

  scope :with_person, -> { includes :person }
  scope :with_votes, -> { includes(:votes).references(:votes) }

  def voted_by?(person)
    votes.by(person).present?
  end
end
