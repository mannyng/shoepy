class ConversationsController < ApplicationController
   before_action :authenticate_request!

  #layout false

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end

    render json: { conversation_id: @conversation.id }
  end

  def show
    @conversation = Conversation.find(params[:id])
    @reciever = interlocutor(@conversation)
    @messages = @conversation.messages
    @message = Message.new
    #my_message =@messages.first
    my_messages = []
    @messages.map do |message|
     my_messages << {message: message,sender: message.customer}
    end
    #my_messages << {messages: @messages,sender: @reciever}
    #render json: my_messages , status: :ok
    render json: @messages , status: :ok
  end

  #  def destroy
  #    @conversation=Conversation.find(params[:id])
  #    @message=@conversation.messages.find(params[:id])
  #    @message.destroy
  #    respond_to do |format|
  #      format.js {render layout:false}
  #    end
  #  end

  private
  
  def conversation_params
    params.require(:conversation).permit(:sender_id, :recipient_id)
  end

  def interlocutor(conversation)
    current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end

end
