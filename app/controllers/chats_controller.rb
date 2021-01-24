class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product, only: %i[ index new ]
  before_action :find_chat, only: %i[ index]
  def index
    show_or_new_chat
  end

  def new
    @chat = @product.chats.new(owner: @product.user, buyer: current_user)
    return redirect_to products_path unless validate_owner_buyer
    redirect_to @chat if @chat.save
  end

  def show
    set_chat
    @message = Message.new
  end

  private

  def find_product
    @product = Product.find(params[:product_id]) || nil
  end

  def find_chat
    @chat = Chat.find_by(product: @product, buyer: current_user) || nil
  end

  def show_or_new_chat
    return redirect_to products_path if @product.nil?
    return redirect_to new_chat_path(product_id: @product) if @chat.nil?
    redirect_to @chat
  end

  def validate_owner_buyer
    !@chat.owner.eql?@chat.buyer
  end

  def set_chat
    if current_user.buyer_chats.include? Chat.find(params[:id])
      @chat = current_user.buyer_chats.find(params[:id])
    else
      @chat = current_user.owner_chats.find(params[:id])
    end
  end
end