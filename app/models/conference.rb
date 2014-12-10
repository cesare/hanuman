class Conference < ActiveRecord::Base
  has_many :proposals
  has_many :staffs

  validates :name, presence: true
  validates :description, presence: true
end
