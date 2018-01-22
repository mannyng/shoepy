class CustomerConnect < ApplicationRecord
    include AASM

 belongs_to :customer
 belongs_to :friend, class_name: 'Customer', foreign_key: 'friend_id'
 
 scope :accepted_connects, ->(state) {where(state: 'accepted') }

  aasm column: "state" do
    state :requested, initial: true
    state :pending
    state :accepted
    state :rejected
    state :blocked

    event :requesting do
     transitions from: [:requested], to: :pending
    end
    event :accept do
     transitions from: [:pending], to: :accepted
    end
   event :reject do
    transitions from: [:pending], to: :rejected
  end
event :block do
    transitions from: [:accepted], to: :blocked
  end

  end

  def self.request(customer1,customer2,subject,msg,customer_connect)
   transaction do
     friendship1 = new(customer_id: customer2, friend_id: customer1, state: 'pending', subject: subject, msg: msg)
     friendship2 = new(customer_id: customer1, friend_id: customer2, state: 'requested', subject: subject, msg: msg)

     friendship1.send_request_email(customer2) #if !friendship1.new_record?
     friendship1.save!
     friendship2.save!
    end
  end

  def send_request_email(customer2)
    #Notification.welcome(friend_id).deliver
    CustomerConnectMailer.welcome(customer2).deliver
  end

  def send_acceptance_email
    CustomerNotifier.friend_request_accepted(id).deliver
  end

  def mutual_connection
   self.class.where({customer_id: friend_id,friend_id: customer_id}).first
  end

end

