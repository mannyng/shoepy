class MessagesController < ApplicationController
    before_action :authenticate_request!
    
    def my_messages
        current_me = Customer.find(params[:id])
        my_messages = current_me.messages
        
        render json: my_messages, status: :ok
    end
    def new
    end
    def create
     @message = Message.new(message_params)
     
      if @message.save
          render json: {message: @message, status: :sent}
         else
          render json: { errors: @message.errors.full_messages }, status: :bad_request
      end
    end
    
    def delete
        message = Message.find(params[:id])
        message.destroy
    end
    
    private
    
    def message_params
        params.require(:message).permit(:customer_id, :reciever_id, :msg)
    end    
end    