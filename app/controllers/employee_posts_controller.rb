class EmployeePostsController < ApplicationController
  require 'geoip'
  
  before_action :authenticate_request! 
  before_action :set_employee_post, only: [:show, :edit, :update, :destroy]

  # GET /employee_posts
  # GET /employee_posts.json
  def index
    @employee_posts = EmployeePost.all
    publicrequests = []
      @employee_posts.each do |employee_post|
        publicrequests << {job_request: employee_post, customer: employee_post.customer}
      end
      render json: publicrequests, status: :ok
  end

  # GET /employee_posts/1
  # GET /employee_posts/1.json
  def public_requests
     #geoip = GeoIP2Compat.new('/opt/GeoIP/GeoLite2-City_20171205/GeoLite2-City.mmdb')
     geoip = GeoIP::City.new('/opt/GeoIP/GeoLiteCity.dat')
     cunnect = geoip.look_up(request.remote_ip)
     locations = EmployeePost.near([cunnect[:latitude],cunnect[:longitude]],200)
     #employers = locations.employer_post
     publicrequests = []
      locations.each do |location|
        publicjobs << {request: location.employer_post}
      end
      render json: publicrequests, status: :ok
  end
  def show
  end

  # GET /employee_posts/new
  def new
    #@employee_post = EmployeePost.new
  end

  # GET /employee_posts/1/edit
  def edit
  end

  # POST /employee_posts
  # POST /employee_posts.json
  def create
    @employee_post = EmployeePost.new(employee_post_params)

      if @employee_post.save
        render json: { employee_post: @employee_post, status: :created }
      else
        render json: {errors:  @employee_post.errors, status: :unprocessable_entity }
      end
    
  end

  # PATCH/PUT /employee_posts/1
  # PATCH/PUT /employee_posts/1.json
  def update
    respond_to do |format|
      if @employee_post.update(employee_post_params)
        format.html { redirect_to @employee_post, notice: 'Employee post was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee_post }
      else
        format.html { render :edit }
        format.json { render json: @employee_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_posts/1
  # DELETE /employee_posts/1.json
  def destroy
    @employee_post.destroy
    respond_to do |format|
      format.html { redirect_to employee_posts_url, notice: 'Employee post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_post
      @employee_post = EmployeePost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_post_params
      params.require(:employee_post).permit(:employee_title,:employee_type,:employee_category,:job_duration,:employee_experience,:customer_id,:job_category,:pay_type,:description)
    end
end