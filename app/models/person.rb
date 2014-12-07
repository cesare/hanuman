class Person < ActiveRecord::Base
  has_many :users
  has_many :proposals

  validates :name, presence: true
end
