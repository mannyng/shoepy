class EmployerPostsController < ApplicationController
    require 'geoip'
    
    before_action :authenticate_request!, except: [:index,:public_jobs,:my_point]
    before_action :set_employer_post, only: [:show,:edit,:update,:destroy]
    
    def index
      employer = EmployerPost.all
      
      render json: employer, status: :ok
    end
   def public_jobs
     #geoip = GeoIP2Compat.new('/opt/GeoIP/GeoLite2-City_20171205/GeoLite2-City.mmdb')
     geoip = GeoIP2Compat.new('/opt/GeoIP/GeoLite2-City_20180102/GeoLite2-City.mmdb')
     cunnect = geoip.lookup(request.remote_ip)
     locations = JobLocation.near([cunnect[:latitude],cunnect[:longitude]],200000)
     #employers = EmployerPost.all
     publicjobs = []
      locations.order(id: :asc).limit(3).each do |location|
        
            publicjobs << {job: location.employer_post, location: location, insight: location.insight, customer: location.customer}
       #publicjobs << {job: job, insight: job.insights, location: job.job_locations}
         
      end
      
      render json: publicjobs, status: :ok
   end
    def my_point
        #geoip = GeoIP2Compat.new('/opt/GeoIP/GeoLite2-City_20171205/GeoLite2-City.mmdb')
        geoip = GeoIP::City.new('/opt/GeoIP/GeoLiteCity.dat')
        @cunnect = geoip.look_up(request.remote_ip)
        render json: @cunnect, status: :ok
    end
     
   def private_jobs
     #geoip = GeoIP2Compat.new('/opt/GeoIP/GeoLite2-City_20171205/GeoLite2-City.mmdb')
     geoip = GeoIP2Compat.new('/opt/GeoIP/GeoLite2-City_20180102/GeoLite2-City.mmdb')
     cunnect = geoip.lookup(request.remote_ip)
     locations = JobLocation.near([cunnect[:latitude],cunnect[:longitude]],200000)
     #employers = EmployerPost.all
     privatejobs = []
      locations.each do |location|
        
            privatejobs << {job: location.employer_post, location: location, insight: location.insight, customer: location.customer}
       
         
      end
      
      render json: privatejobs, status: :ok
   end
    def show
     insight = @employer_post.insight      
     #location = @employer_post.job_locations
    
    render json: insight, status: :ok
    end
  
    def new
    @employer_post = EmployerPost.new
    @employer_post.insight.build
    end
    
    def create
      @employer_post = EmployerPost.new(employer_post_params)
      #employer_post.customer_id = 1
      #insight  = params[:insight]
      #employer_post.insight.build
      if @employer_post.save
        render json: {employer_post: @employer_post, status: 'Employer Post created successfully'}, status: :created
      else
        render json: { errors: @employer_post.errors.full_messages }, status: :bad_request
      end
    end
    
    private
    
    def employer_post_params
      params.require(:employer_post).permit(:id, :customer_id, :title, :description, insight_attributes:[:available_date,
      :job_category,:employee_category,:job_duration,:pay_type,:employee_type,:employee_title,:employee_experience])
    end
    def set_employer_post
        @employer_post = EmployerPost.find(params[:id])
    end 

end