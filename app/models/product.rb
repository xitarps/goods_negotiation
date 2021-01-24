class Product < ApplicationRecord
  has_many :chats
  belongs_to :user
  enum available: { disponivel: true , indisponivel: false }
  
end
