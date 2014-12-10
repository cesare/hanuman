class Person < ActiveRecord::Base
  has_many :users
  has_many :proposals
  has_many :staffs

  validates :name, presence: true
end
