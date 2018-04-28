class JobLocationsController < ApplicationController
  before_action :authenticate_request! , only: [:edit,:update,:destroy,:new,:create]
  before_action :set_job_location, only: [:show, :edit, :update, :destroy]

  # GET /job_locations
  # GET /job_locations.json
  def index
    @job_locations = JobLocation.all
  end

  # GET /job_locations/1
  # GET /job_locations/1.json
  def show
  end

  # GET /job_locations/new
  def new
    @job_location = JobLocation.new
  end

  # GET /job_locations/1/edit
  def edit
  end

  # POST /job_locations
  # POST /job_locations.json
  def create
    @job_location = JobLocation.new(job_location_params)

    
      if @job_location.save
      render json: {job_location: @job_location, status: 'Job location was successfully created.'}, status: :created
      else
        render json: { errors: @job_location.errors.full_messages }, status: :bad_request  
      end
  
  end
  # PATCH/PUT /job_locations/1
  # PATCH/PUT /job_locations/1.json
  def update
    
      @job_location.update(job_location_params)
  
  end
  # DELETE /job_locations/1
  # DELETE /job_locations/1.json
  def destroy
    @job_location.destroy
    respond_to do |format|
      format.html { redirect_to job_locations_url, notice: 'Job location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_location
      @job_location = JobLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_location_params
      params.require(:job_location).permit(:location, :city, :state, :employer_post_id )
    end

    def my_customer
      Customer.find_by_user_id(current_user.id)
    end
end
        




