class Proposal < ActiveRecord::Base
  belongs_to :conference
  belongs_to :person

  validates :conference, presence: true
  validates :person, presence: true
  validates :title, presence: true
  validates :summary, presence: true
end
