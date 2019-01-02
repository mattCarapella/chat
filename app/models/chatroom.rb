class Chatroom < ApplicationRecord
	has_many :chatroom_users
	has_many :users, through: :chatroom_users
	has_many :messages

	scope :public, -> { where(direct_message: false) }
	scope :direct_messages, -> { where(direct_message: true) }
end
