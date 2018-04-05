class CustomerConnectsController < ApplicationController
  before_action :authenticate_request! , only: [:edit,:update,:destroy,:new,:create]


   def index
      #@customer_connects = my_customer.customer_connnect #(connect_association)
      @customer_connects = CustomerConnect.all
   end

   def my_connections
    myconnections = []
     @customer = Customer.find(params[:customer_id])
     #@customer = Customer.find_by_user_id(params[:customer_id])
     #@customer.customer_connects.accepted_connects.each do |cc|
     
       @customer.customer_connects.each do |cc|
        myconnections << {customer_connect: cc, friend: cc.friend, customer: cc.customer}
       end
       #@customer.accepted_customer_connects.accepted_connects.each do |cc|
       @customer.accepted_customer_connects.each do |cc|
        myconnections << {customer_connect: cc, friend: cc.friend, customer: cc.customer}
       end  
       render json: myconnections, status: :ok
   end
    
  def accept
   if params[:id]
   
    @customer_connect = CustomerConnect.find(params[:id])
   
    if @customer_connect.accept!
     CustomerConnect.create_discussion(@customer_connect)
     #current_customer.create_activity @customer_connect, 'accepted'
     CustomerConnectMailer.friend_request_accepted(@customer_connect.friend).deliver
     render json: { customer_connect: @customer_connect, status: :created }
     else
       render json: {errors:  @customer_connect.errors, status: :unprocessable_entity }
    end
   end
      #render json: @customer_connect, status: "Please try again or check your logs"
  end
   def requesting
     @customer_connect = CustomerConnect.find(params[:id])
     if @customer_connect.requesting!
      #CustomerConnectMailer.welcome(current_customer.full_name).deliver
      flash[:success] = "Your are now connected with #{@customer_connect.friend.full_name }"
    else
     flash[:error] = "The connect request is not accepted"
     end
      redirect_to customer_connects_path
   end

   def new
     if params[:customer_id]
       @friend = Customer.find(params[:customer_id])
       raise ActiveRecord::RecordNotFound if @friend.nil?
     @customer_connect = current_customer.customer_connects.new(friend: @friend)
       else
       flash[:error] = "Friend require"
     end
      rescue ActiveRecord::RecordNotFound
        render file: 'public/404', status: :not_found
   end
 def create
  if params[:customer_connect] && params[:customer_connect].has_key?(:friend_id)
  @friend = Customer.find(params[:friend_id])
  subject = "Connect" #params[:subject]
  msg = "I will like to connect with you sir/madam" #params[:msg]
  @customer_id = params[:customer_id]
  #@state = params[:state]
  #@customer_connect = CustomerConnect.new(customer_con_params)
  #@customer_connect = CustomerConnect.request(@customer_id, @friend, @subject, @msg,@customer_connect)  
   #@customer_connect = CustomerConnect.create(customer_con_params)
   #@customer_connect.state = "requested"
   ActiveRecord::Base.transaction do
     @friendship1 = CustomerConnect.create(customer_id: @friend.id, friend_id: @customer_id, state: 'pending', subject:"Connect", msg:"I will like to connect with you sir/madam")
     @friendship2 = CustomerConnect.create(customer_id: @customer_id, friend_id: @friend.id, state: 'requested', subject: subject, msg: "I will like to connect with you sir/madam")
   end
   #@customer_connect.save!
   #respond_to do |format|
    if @friendship1.new_record?
     #format.html do
     # flash[:error] = "There was a problem with you connect request"
     # redirect_to employer_posts_path
     # end
    format.json { render json: @customer_connect, status: :precondition_failed}
    else
     CustomerConnectMailer.welcome(@friend).deliver
     #@customer_connect.requesting!
     #format.html do 
      #flash[:success] = "Connect request sent"
      #redirect_to customer_path(@customer_connect.customer_id)
     #end
     #format.json { render json: @customer_connect }
    end
   #end 
   else
    format.json { render json: @customer_connect.errors,  status: :Friend_required}
   redirect_to root_path
  end
 end
  def edit
   @friend = Customer.find(params[:friend_id])
   customer_connect = CustomerConnect.where({customer_id: current_customer.id}&&{friend_id: @friend.id})
   @customer_connect = customer_onnect.update!(customer_con_params)
   #@customer_connect = current_customer.customer_connects.new(friend_id: @friend.id)
  end
   def destroy
    @customer_connect = CustomerConnect.find(params[:id])
     @customer_connect.destroy!
      #format.json { head :no_content }
   end
     

  private
   def customer_con_params
    params.require(:customer_connect).permit(:customer_id,:friend_id,:subject,:msg,:state)
  end
   def connect_association
     case params[:list]
      when nil
       current_customer.customer_connects
      when "blocked"
       current_customer.blocked_customer_connects
      when "pending"
       current_customer.pending_customer_connects
      when "accepted"
       current_customer.accepted_customer_connects
      when "requested"
       current_customer.requested_customer_connects
     end
   end   

end