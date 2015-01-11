class Person < ActiveRecord::Base
  has_many :users
  has_many :proposals
  has_many :staffs
  has_many :votes
  has_many :running_conferences, through: :staffs, class_name: 'Conference', source: 'conference'

  validates :name, presence: true
  validates :email, presence: true

  scope :admin, -> { where admin: true }
end
