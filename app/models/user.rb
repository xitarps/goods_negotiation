class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :owner_chats, class_name: 'Chat', foreign_key: 'owner_id'
  has_many :buyer_chats, class_name: 'Chat', foreign_key: 'buyer_id'
  has_many :messages
end
