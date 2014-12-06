class User < ActiveRecord::Base
  validates :name, presence: true
  validates :uid, presence: true
  validates :provider, presence: true
end
