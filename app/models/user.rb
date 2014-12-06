class User < ActiveRecord::Base
  belongs_to :person

  validates :name, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :provider, presence: true
  validates :person, presence: true
end
