class Conference < ActiveRecord::Base
  has_many :proposals
  has_many :staffs

  validates :name, presence: true
  validates :description, presence: true
  validates :begins_at, presence: true
  validates :ends_at, presence: true
end
