class Conference < ActiveRecord::Base
  has_many :proposals

  validates :name, presence: true
  validates :description, presence: true
end
