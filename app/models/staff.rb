class Staff < ActiveRecord::Base
  belongs_to :conference
  belongs_to :person

  validates :conference, presence: true
  validates :person, presence: true
end
