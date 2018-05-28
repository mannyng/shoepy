class MessagesController < ApplicationController
   before_action :authenticate_request!
   before_action :set_sender_customer, only: [:create]

  def read
   if params[:id]
    @message= Message.find(params[:id])
   
    if @message.read!
     render json: {status: :created }
     else
       render json: {errors:  @message.errors, status: :unprocessable_entity }
    end
  end
   
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.sender_name = @customer.username
    if @message.save!
    #PrivatePub.publish_to "/chatroom", :conversation_id => @conversation.id, :receiver_id => @conversation.recipient_id
    #@path = conversation_path(@conversation)
      render json: @message, status: :ok
    else
      render json: @message.errorfull_messages, status: :bad_request  
    end 
  end


  private

  def message_params
    params.require(:message).permit(:msg,:conversation_id,:customer_id)
    #params.require(:message).permit(:customer_id, :reciever_id, :msg)
  end
  def set_sender_customer
    @customer = Customer.find(params[:customer_id])
  end
end

