class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

    def index
     @cart = Cart.all
    end
    def show
    end
    def update
    end
    def destroy
        @cart.destroy if @cart.id == session[:cart_id]
        session[:cart_id] = nil
        render json: {head: :no_content}
    end
    
    private
    
    def set_cart
        @cart = Cart.find(params[:id])
    end
    def invalid_cart
     logger.error “Attempt to access invalid cart #{params[:id]}”
     #redirect_to_store_url, notice: “Invalid cart”
    end
    
end    