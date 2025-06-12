class Account < ApplicationRecord
  has_one_attached :logo
  has_many :user_accounts
  has_many :users, through: :user_accounts
  has_many :events
  has_many :tickets
  has_many :orders
  has_one :account_setting
  has_one_attached :cover_image
end
