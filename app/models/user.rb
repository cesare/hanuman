class User < ActiveRecord::Base
  belongs_to :person

  validates :name, presence: true
  validates :uid, presence: true
  validates :provider, presence: true
  validates :person, presence: true
end
