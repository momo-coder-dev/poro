class UserAccount < ApplicationRecord
  belongs_to :user
  belongs_to :account

  validates :user_id, uniqueness: true # { scope: :account_id }
end
