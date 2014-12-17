class Person < ActiveRecord::Base
  has_many :users
  has_many :proposals
  has_many :staffs
  has_many :votes

  validates :name, presence: true

  scope :admin, -> { where admin: true }
end
