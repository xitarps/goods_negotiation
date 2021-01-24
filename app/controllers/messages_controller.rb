class MessagesController < ApplicationController
  before_action :authenticate_user!
  def create
    return redirect products_path unless belongs_this_chat
    @message = @chat.messages.new(body: message_params[:body], user: current_user)
    return redirect_to @chat if @message.save
  end

  private

  def message_params
    params.require(:message).permit(:body, :chat)
  end

  def find_chat
    @chat = Chat.find(message_params[:chat])
  end
  def belongs_this_chat
    find_chat
    return true if current_user.owner_chats.include?@chat
    return true if current_user.buyer_chats.include?@chat
    false
  end
end
