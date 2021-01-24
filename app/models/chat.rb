class Chat < ApplicationRecord
  belongs_to :product
  belongs_to :owner, class_name: 'User'
  belongs_to :buyer, class_name: 'User'
  has_many :messages
end
