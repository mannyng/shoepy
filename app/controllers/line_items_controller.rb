class LineItemsController < ApplicationController
include CurrentCart
before_action :set_cart, only: [:create]
before_action :set_line_item, only: [:show, :edit, :update, :destroy]

 def create
     @product_id = params[:product_id]
  product = Product.find(@product_id)
  @line_item = @cart.add_product(product.id,params[:user_id])
  if @line_item.save
   render json: @line_item
  else
      #render json: {error: 'Email not verified' }, status: :unauthorized
   render json: @line_item.errors, status: :unprocessable_entity
  end
 end
 
 private
 
 def line_item_params
  params.require(:line_item).permit(:product_id,user_id)
 end
 
end