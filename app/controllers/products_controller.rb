class ProductsController  < ApplicationController


  def index
    @products = Product.all
    render json: @products, status: :ok
  end

  def new
  end

  def create
      #@product = Product.new(product_params)
      @product = Product.new(product_params)
      @product.id = SecureRandom.random_number(99999999999999)
      if @product.save
        render json: @product, status: :ok
      else
        render json: @product.errors, status: :unprocessable_entity
      end
  end

  private

   def product_params
       params.require(:product).permit(:title,:description,:image_url,:price,:status,avatars: [])
   end

   def set_product
       @product = Product.find(params[:id])
   end

end
