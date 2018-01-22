class EmployerPostsController < ApplicationController
    before_action :authenticate_request!, except: [:index,:public_jobs]
    before_action :set_employer_post, only: [:show,:edit,:update,:destroy]
    
    def index
      employer = EmployerPost.all
      
      render json: employer, status: :ok
    end
   def public_jobs
     #geoip = GeoIP2Compat.new('/opt/GeoIP/GeoLite2-City_20171205/GeoLite2-City.mmdb')
     geoip = GeoIP2Compat.new('/opt/GeoIP/GeoLite2-City_20180102/GeoLite2-City.mmdb')
     cunnect = geoip.lookup(request.remote_ip)
     locations = JobLocation.near([cunnect[:latitude],cunnect[:longitude]],200)
     #employers = locations.employer_post
     publicjobs = []
      locations.each do |location|
        publicjobs << {job: location.employer_post, location: locations}
       #publicjobs << {job: job, insight: job.insights, location: job.job_locations}
      end
      render json: publicjobs, status: :ok
   end
    def show
     insight = @employer_post.insights      
     #location = @employer_post.job_locations
    
    render json: insight, status: :ok
    end
  
    def new
    end
    
    def create
      employer_post = EmployerPost.new(employer_post_params)
      #employer_post.customer_id = 1
      
      if employer_post.save
        render json: {employer_post: employer_post, status: 'Employer Post created successfully'}, status: :created
      else
        render json: { errors: employer_post.errors.full_messages }, status: :bad_request
      end
    end
    
    private
    
    def employer_post_params
      params.require(:employer_post).permit(:id, :customer_id, :title, :description)
    end
    def set_employer_post
        @employer_post = EmployerPost.find(params[:id])
    end 

end