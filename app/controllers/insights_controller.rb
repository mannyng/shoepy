class InsightsController < ApplicationController
  before_action :authenticate_request! , only: [:edit,:update,:destroy,:new,:create]
  before_action :set_insight, only: [:show, :edit, :update, :destroy]

 def index
  @insights = Insight.all
 end

 def show
 end

 def new
  @insight = Insight.new
 end

 def edit
 end

  def create
    @insight = Insight.new(insight_params)
    #@customer.user_id = current_user.id
    @insight.available_date = Time.now

    
      if @insight.save
        render json: @insight, status: :created
      else
        render json: { errors: @insight.errors.full_messages }, status: :bad_request
      end
    
  end

    def update
       @insight.update_attributes(insight_params)
    end

  def destroy
    @insight.destroy
    respond_to do |format|
      format.html { redirect_to insights_url, notice: 'Insight was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

 private
  def set_insight
   @insight = Insight.find(params[:id])
  end
    
  def insight_params
    params.require(:insight).permit(:job_category, :employee_category, :job_duration, :pay_type, :employee_type, :employee_title, :employer_post_id, :employee_experience)
  end

  def mycustomer
    @customer.user_id == current_user.id
  end

end
      
        
        
        