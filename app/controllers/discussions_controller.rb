class DiscussionsController < ApplicationController
  before_action :authenticate_request! , only: [:edit,:update,:destroy,:new,:create]
  
  
  def new
  end
  
    def create
        #customer_connect = params([:customer_connect_id])
       @discussion = Discussion.create!(discussion_params)
        if @discussion.valid?
           render json: { status: :ok }
        else
            render json: {errors: @discussion.errors, status: :unprocessable_entity}
        end
    end
    
    private
    def discussion_params
      params.require(:discussion).permit(:customer_connect_id)
    end
end  