class CustomersController < ApplicationController
    before_action :authenticate_request!
    before_action:set_customer, only: [:edit,:update,:destroy]
    
    def index
        @customers = Customer.all
    end
    
    def show
        #@user = User.find(params[:id])
        #myprofile = @user.customer
        myprofile = Customer.find_by_user_id(params[:id])
        #myconvos = Conversation.involving(myprofile)
        myposts = []
        if myprofile.customer_type == 'employer'
          myposts = myprofile.employer_posts
        elsif myprofile.customer_type == 'employee'
          myposts = myprofile.employee_posts
        end  
        messages = []
        myconv = []
        myprofile.friends.each do |x|
          messages <<  {friend: x, x_messages: x.messages} 
         end
         convos = Conversation.involving(myprofile)
       #myprofile.conversations.each do |y|
       convos.each do |y|
           myconv << {messagas: y.messages,sender: y.sender, recipient: y.recipient}
        end   
        render json: {myprofile: myprofile, mymessages: messages, myconv: myconv, myposts: myposts, status: :ok}
    end
    def myconvos
        myconvos = []
        customer = Customer.find_by_user_id(params[:id])
        convos = Conversation.involving(customer)
        
        convos.each do |y|
           myconvos << {messagas: y.messages.reverse.first,sender: y.sender, recipient: y.recipient}
        end 
        render json: myconvos,status: :ok
    end    
    def myposts
       myposts = []
        customer = Customer.find_by_user_id(params[:id])
        if customer.customer_type == 'employer'
        customer.employer_posts.each do |mypost|
            myposts << {mypost: mypost, insight: mypost.insight, location: mypost.job_location}
        end
        elsif customer.customer_type == 'employee'
          myposts = customer.employee_posts
        end
        render json: myposts, status: :ok
    end 
    
    
   def my_friends
     #friends = []
     customer = Customer.find_by_user_id(params[:id])
     my_friends = customer.friends
     render json: my_friends, status: :ok
   end
   
    def new
    end
    
    def create
        customer = Customer.new(customer_params)
        customer.country = 'nigeria'
        
        if customer.save
          render json: {status: 'Customer created successfully'}, status: :created
         else
          render json: { errors: customer.errors.full_messages }, status: :bad_request
        end
    end
    
    def edit
    end
    
    def update
    end
    
    def destroy
        @customer.destroy!
    end
    
    private
    
    def customer_params
        params.require(:customer).permit(:username,:firstname,:lastname,:address,:city,:state,
        :country,:customer_type,:user_id)
    end
    
    def set_customer
        @customer = Customer.find(params[:id])
    end
    
end