class User < ActiveRecord::Base
  # basic validations, email and password need to be expanded
  validates :username, presence: true
  validates :password, presence: true
  validates :email, presence: true
end
